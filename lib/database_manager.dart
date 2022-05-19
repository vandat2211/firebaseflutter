import 'package:cloud_firestore/cloud_firestore.dart';
class FireStoreDatabase{
List songlist=[];
final CollectionReference collectionReference=FirebaseFirestore.instance.collection("songs");
Future getData()async{
  try{
    await collectionReference.get().then((querySnapshot){
      for(var result in querySnapshot.docs){
        songlist.add(result.data());
      }
    });
    return songlist;
  }catch(e){
    return null;
  }
}
}