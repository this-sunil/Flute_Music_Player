import 'dart:io';
import 'package:cycles/MPInheritedWidget.dart';
import 'package:cycles/song.dart';
import 'package:flutter/material.dart';
import 'NowPlaying.dart';
class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  SongData songData;
  @override
  void initState() { 
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final root=MPInheritedWidget.of(context);
    songData=root.songData;
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications_none), onPressed: (){}),
        ],
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
                child: ListTile(
                leading: s.albumArt==null?CircleAvatar(child: Icon(Icons.music_note)):ClipOval(child:Image.file(File.fromUri(Uri.parse(s.albumArt)),fit: BoxFit.cover,)),
                title: Text(s.title),
                subtitle: Text(s.artist),
                trailing:Text('${Duration(milliseconds: s.duration).toString().split('.')[0]}'),
                onTap: (){
                  songData.setCurrentIndex(index);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NowPlaying(songData,s)));
                },
              ),
            ),
          );
        }),
        
    );
  }
}
