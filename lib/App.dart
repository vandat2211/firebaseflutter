import 'package:firebaseflutter/upload.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentindex=0;
  List tabs=[
    Home(),
    Upload(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Music Player App"),),
      body: tabs[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.cloud_upload),
              label: "Upload")
        ],
        onTap: (index){
          setState(() {
            currentindex=index;
          });

        },
      ),
    );
  }
}
