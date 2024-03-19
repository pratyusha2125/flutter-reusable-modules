import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class MediaIntegration extends StatefulWidget {
  @override
  _MediaIntegrationState createState() => _MediaIntegrationState();
}

class _MediaIntegrationState extends State<MediaIntegration> {
  late AssetsAudioPlayer _audioPlayer;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  Duration? _lastAudioPosition;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AssetsAudioPlayer();

    _videoPlayerController = VideoPlayerController.network(
      'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
    );
  }

  void _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      _audioPlayer.open(
        Audio.file(file.path!),
        showNotification: true,
        loopMode: LoopMode.none,
      );
    }
  }

  void _stopAudio() {
    _lastAudioPosition = _audioPlayer.currentPosition.value;
    _audioPlayer.stop();
  }

  void _resumeAudio() {
    if (_lastAudioPosition != null) {
      _audioPlayer.seek(_lastAudioPosition!);
      _audioPlayer.play();
    }
  }

//method for audio
  void _pauseAudio() {
    _audioPlayer.pause();
  }

  void _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;

      _videoPlayerController.dispose();
      _chewieController?.dispose();

      _videoPlayerController = VideoPlayerController.file(
        File(file.path ?? ""),
      );

      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoPlay: false,
        looping: false,
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Chewie(controller: _chewieController!),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio & Video Player"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAudio,
              child: Text(
                "Pick and Play Audio",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 226, 123, 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pauseAudio,
              child: Text(
                "Pause Audio",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 226, 123, 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text(
                "Pick and Play Video",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 226, 123, 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
            ),
            SizedBox(height: 20),
            _chewieController != null &&
                    _chewieController.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: _chewieController,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
