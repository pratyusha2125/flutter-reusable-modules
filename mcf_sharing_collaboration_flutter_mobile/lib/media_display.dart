import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class MediaDisplayPage extends StatefulWidget {
  final List<File> images;
  final List<File> videos;

  MediaDisplayPage({required this.images, required this.videos});

  @override
  _MediaDisplayPageState createState() => _MediaDisplayPageState();
}

class _MediaDisplayPageState extends State<MediaDisplayPage> {
  List<bool> _selectedMedia = [];

  @override
  void initState() {
    super.initState();
    _selectedMedia.addAll(List.generate(
        widget.images.length + widget.videos.length, (index) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Media'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('All Images:'),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...widget.images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _toggleSelectedMedia(entry.key),
                    child: Stack(
                      children: [
                        Image.file(
                          entry.value,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        if (_selectedMedia[entry.key])
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 20),
            Text('All Videos:'),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ...widget.videos.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () =>
                        _toggleSelectedMedia(entry.key + widget.images.length),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.video_library,
                          size: 100,
                          color: Colors.blue,
                        ),
                        if (_selectedMedia[entry.key + widget.images.length])
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _shareSelectedMedia(),
              child: Text(
                'Share Selected Media',
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

  void _toggleSelectedMedia(int index) {
    setState(() {
      _selectedMedia[index] = !_selectedMedia[index];
    });
  }

  Future<void> _shareSelectedMedia() async {
    final List<String> mediaPaths = [];

    for (int i = 0; i < _selectedMedia.length; i++) {
      if (_selectedMedia[i]) {
        if (i < widget.images.length) {
          mediaPaths.add(widget.images[i].path);
        } else {
          mediaPaths.add(widget.videos[i - widget.images.length].path);
        }
      }
    }

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
}
