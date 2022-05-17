import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'dart:io';
class FirebaseApi{
  static UploadTask? uploadFile(String destination,File file){
    try{
      final ref=FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    }on FirebaseException catch(e){
      return null;
    }

  }
}