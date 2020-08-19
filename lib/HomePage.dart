import 'package:music/MusicPage.dart';
import 'package:music/song.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'MPInheritedWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SongData songData;
  Song song;
  List<Song> songs;
  @override
  void initState() { 
    super.initState();
    initPlayer();
    setState(() {
      if(!mounted)return;
    });
  }
  @override
  void dispose() { 
    songData.musicFinder.stop();
    super.dispose();
  }
  Future initPlayer() async{
    try {
      songs=await MusicFinder.allSongs();
    } catch (e) {
      print("Failed to get songs :'${e.message}'");
    }
    print(songs);
    setState(() {
      songData=SongData((songs));
    });
  }
  @override
  Widget build(BuildContext context) => MPInheritedWidget(songData,song,MusicPage());
}
