import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcf_sharing_collaboration_flutter_mobile/media_display.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> _images = [];
  List<File> _videos = [];
  // Add list to track selected media
  List<bool> _selectedMedia = []; // Added list to track selected media

  @override
  void initState() {
    super.initState();
    // _selectedMedia.addAll(List.generate(2, (index) => false));
    _loadMediaFromStorage();
  }

  Future<void> _loadMediaFromStorage() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDocDir.listSync();

    for (final file in files) {
      if (file is File) {
        if (file.path.endsWith('.jpg') || file.path.endsWith('.jpeg')) {
          _images.add(file);
          _selectedMedia.add(false);
        } else if (file.path.endsWith('.mp4')) {
          _videos.add(file);
          _selectedMedia.add(false);
        }
      }
    }

    setState(() {});
  }

  Future<void> _takePhoto() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageFile == null) return;

    final File newImage = File(imageFile.path);

    // Save to app's gallery
    await _saveToAppGallery(newImage);

    // Save to device's gallery using gallery_saver
    await GallerySaver.saveImage(newImage.path);

    setState(() {
      _images.add(newImage);
      _selectedMedia[0] = true; // Select image by default
    });
  }

  Future<void> _takeVideo() async {
    final videoFile = await ImagePicker().pickVideo(source: ImageSource.camera);

    if (videoFile == null) return;

    final File newVideo = File(videoFile.path);

    // Save to app's gallery
    await _saveToAppGallery(newVideo);

    // Save to device's gallery using gallery_saver
    await GallerySaver.saveVideo(newVideo.path);

    setState(() {
      _videos.add(newVideo);
      _selectedMedia[1] = true; // Select video by default
    });
  }

  Future<void> _saveToAppGallery(File media) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final String localPath =
        '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.${media.path.split('.').last}';

    await media.copy(localPath);
  }

  Future<void> _shareMedia(List<File> mediaList) async {
    final List<String> mediaPaths = mediaList
        .asMap()
        .entries
        .where(
            (entry) => _selectedMedia[entry.key]) // Only share selected media
        .map((entry) => entry.value.path)
        .toList();

    if (mediaPaths.isNotEmpty) {
      final String text = 'Check out these media files!';
      await Share.shareFiles(mediaPaths, text: text);
    } else {
      // Handle case where no media is selected
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No Media Selected'),
            content:
                Text('Please select at least one image or video to share.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Gallery'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text(
                'Take Photo',
                style: const TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 226, 123, 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
            ),
            ElevatedButton(
              onPressed: _takeVideo,
              child:
                  Text('Record Video', style: TextStyle(color: Colors.white)),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MediaDisplayPage(images: _images, videos: _videos),
                  ),
                );
              },
              child: Text(
                'View All Media',
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
          ],
        ),
      ),
    );
  }
}
