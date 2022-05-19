import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class Songspage extends StatefulWidget {
String song_url,img_url,song_name,artist_name;
Songspage({
  required this.song_name,required this.artist_name,required this.img_url,required this.song_url
});
  @override
  State<Songspage> createState() => _SongspageState();
}

class _SongspageState extends State<Songspage> {
   late AudioPlayer audioPlayer;
  @override
  void initState() {
    super.initState();
    ok();
  }
   Future<void> ok() async{
     audioPlayer=AudioPlayer();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player App"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0,),
            Text(widget.song_name,style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 5.0,),
            Text(widget.artist_name,style: TextStyle(
              fontSize: 15.0,
            ),),
            SizedBox(height: 5.0,),
            Card(
              child: Image.network(widget.img_url,height: 350.0,),
              elevation: 10.0,
            ),
            SizedBox(height: 15.0,),
            Row(
              children: <Widget>[
                SizedBox(width: 100.0,),
                Expanded(child: FlatButton(
                  onPressed: (){audioPlayer.play(widget.song_url);},
                  child: Icon(Icons.play_arrow,size: 50.0,),

                )),
                Expanded(child: FlatButton(
                  onPressed: (){audioPlayer.stop();},
                  child: Icon(Icons.stop,size: 50.0,),

                )),
                SizedBox(width: 100.0,)
              ],
            )
          ],
        ),
      ),
    );
  }


}
