import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'song.dart';
class MPInheritedWidget extends InheritedWidget{
  final SongData songData;
  final Song song;
  MPInheritedWidget(this.songData,this.song,child):super(child:child);

  static MPInheritedWidget of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType(aspect: MPInheritedWidget);
  }
  @override
  bool updateShouldNotify(MPInheritedWidget oldWidget)=>songData!=oldWidget.songData && song!=oldWidget.song;

}
