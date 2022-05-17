import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseflutter/FirebaseApi.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController songname = TextEditingController();
  TextEditingController artistname = TextEditingController();
  File? file1,file2;
  UploadTask? task;
  var image_url,song_url;
  final firestore=FirebaseFirestore.instance;
  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final image_url = result.files.single.path!;
    setState(() => file1 = File(image_url));
  }
  Future selectSong() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file2 = File(path));
  }
Future upload()async {
  if (file1 == null || file2 == null) return;
  final filename = basename(file1!.path);
  final filename2 = basename(file2!.path);
  final destination = 'files/$filename';
  final destination2 = 'files/$filename2';
  FirebaseApi.uploadFile(destination, file1!);
  FirebaseApi.uploadFile(destination2, file2!);

  var data= {
    "song_name": songname.text,
    "artist_name": artistname.text,
    "img_url": image_url.toString(),
    "song_url": file2.toString(),
  };
  firestore.collection("songs").doc().set(data);
}



  @override
  Widget build(BuildContext context) {
    final filename = file1 != null ? basename(file1!.path) : 'No file selected';
    final filename2 = file2 != null ? basename(file2!.path) : 'No file selected';
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              selectImage();
            },
            child: Text("Select Image"),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            filename,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          RaisedButton(
            onPressed: () {
              selectSong();
            },
            child: Text("Select Song"),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            filename2,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: songname,
              decoration: InputDecoration(
                hintText: "Enter song name",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: artistname,
              decoration: InputDecoration(
                hintText: "Enter artist name",
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              upload();
            },
            child: Text("Upload"),
          )
        ],
      ),
    );
  }
}
