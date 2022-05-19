import 'package:firebaseflutter/songspage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:just_audio/just_audio.dart';

import 'database_manager.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FireStoreDatabase().getData(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("Somthing went wrong");
          }
          if(snapshot.connectionState==ConnectionState.done){
            dataList=snapshot.data as List;
            return buildItems(dataList,snapshot);
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Widget buildItems(List dataList, snapshot)=>ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: dataList.length,
    separatorBuilder: (BuildContext context,int index)=> const Divider(),
    itemBuilder: (BuildContext context,int index){
      return ListTile(
        title: Text(dataList[index]["song_name"]),
        subtitle: Text(dataList[index]["artist_name"]),
        onTap: () async{ Navigator.push(context, MaterialPageRoute(builder: (context)=>Songspage(
          song_name:dataList[index]["song_name"],
            artist_name:dataList[index]["artist_name"],
            img_url:dataList[index]["img_url"],
            song_url:dataList[index]["song_url"],
        )));
      },
      );
    },
  );
}
