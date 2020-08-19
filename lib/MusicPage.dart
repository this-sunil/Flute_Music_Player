import 'dart:io';
import 'package:music/MPInheritedWidget.dart';
import 'package:music/song.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'NowPlaying.dart';
class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  SongData songData;
  List<Song> song;
  @override
  void initState() { 
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final root=MPInheritedWidget.of(context);
    songData=root.songData;
    void goToNowPlaying(Song s) {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new NowPlaying(
                    root.songData,
                    s,
      )));
    }
    //Shuffle Songs and goto now playing page
    void shuffleSongs() {
      goToNowPlaying(root.songData.randomSong);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
      ),
      body: ListView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount:songData?.song?.length ?? 0,
      itemBuilder: (context,index){
        var s=songData.song[index];
        return Hero(
              tag: s.title,
              child: Card(
              color: Color(0xFF333945),
              child: ListTile(
              
              leading: s.albumArt==null?CircleAvatar(child: Icon(Icons.music_note)):CircleAvatar(backgroundImage:FileImage(File.fromUri(Uri.parse(s.albumArt)))),
              title: Text(s.title,style: TextStyle(color: Colors.white)),
              subtitle: Text(s.artist,style: TextStyle(color: Colors.white)),
              onTap: (){
                songData.setCurrentIndex(index);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NowPlaying(songData,s)));
              },
            ),
          ),
        );
      }),
       floatingActionButton: FloatingActionButton(
         backgroundColor: Color(0xFF333945),
         onPressed: (){
         setState(() {
           shuffleSongs();
         });
       },child: Icon(Icons.shuffle),), 
    );
  }
}