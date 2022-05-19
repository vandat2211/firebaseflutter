import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  PlatformFile? pickedImage,pickedSong;
UploadTask? uploadTask,uploadTask1;
  final firestore=FirebaseFirestore.instance;
  Future upload()async {
    if (pickedImage == null || pickedSong == null) return;
    final path_img='files/${pickedImage!.name}';
    final fileimg=File(pickedImage!.path!);
    final ref=FirebaseStorage.instance.ref().child(path_img);
    uploadTask=ref.putFile(fileimg);
    final snapsot =await uploadTask!.whenComplete(() {});
    final url_img=await snapsot.ref.getDownloadURL();

    final path_song='files/${pickedSong!.name}';
    final filesong=File(pickedSong!.path!);
    final ref1=FirebaseStorage.instance.ref().child(path_song);
    uploadTask1=ref1.putFile(filesong);
    final snapsot1 =await uploadTask1!.whenComplete(() {});
    final url_song=await snapsot1.ref.getDownloadURL();


    var data= {
      "song_name": songname.text,
      "artist_name": artistname.text,
      "img_url": url_img.toString(),
      "song_url": url_song.toString(),
    };
    firestore.collection("songs").doc().set(data);
  }
  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedImage=result.files.first;
    });
  }
  Future selectSong() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedSong=result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filename = pickedImage != null ? basename(pickedImage!.path!) : 'No file selected';
    final filename2 = pickedSong != null ? basename(pickedSong!.path!) : 'No file selected';
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
