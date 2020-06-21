import 'package:devhacks/services/firebase.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class Files extends StatefulWidget {
  static const routeName = "/files";

  @override
  _FilesState createState() => _FilesState();
}

class _FilesState extends State<Files> {
  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  String result = '';

  Future filePicker(BuildContext context, String fileType) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.IMAGE);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        FireStorage.uploadFile(file, fileType, fileName);
      }
      if (fileType == 'audio') {
        file = await FilePicker.getFile(type: FileType.AUDIO);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        FireStorage.uploadFile(file, fileType, fileName);
      }
      if (fileType == 'video') {
        file = await FilePicker.getFile(type: FileType.VIDEO);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        FireStorage.uploadFile(file, fileType, fileName);
      }
      if (fileType == 'pdf') {
        file = await FilePicker.getFile(
            type: FileType.CUSTOM, fileExtension: 'pdf');
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        FireStorage.uploadFile(file, fileType, fileName);
      }
      if (fileType == 'others') {
        file = await FilePicker.getFile(type: FileType.ANY);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        FireStorage.uploadFile(file, fileType, fileName);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Image',
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.image,
                color: Colors.redAccent,
              ),
              onTap: () {
                filePicker(context, 'image');
              },
            ),
            ListTile(
              title: Text(
                'Audio',
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.audiotrack,
                color: Colors.redAccent,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Video',
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.video_label,
                color: Colors.redAccent,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'PDF',
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.pages,
                color: Colors.redAccent,
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Others',
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(
                Icons.attach_file,
                color: Colors.redAccent,
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              result,
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.view_list),
              onPressed: () {},
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Firestorage - files',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
