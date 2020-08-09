import 'package:flutter/material.dart';
import 'song.dart';
class MPInheritedWidget extends InheritedWidget{
  final SongData songData;
  MPInheritedWidget(this.songData,child):super(child:child);

  static MPInheritedWidget of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType(aspect: MPInheritedWidget);
  }
  @override
  bool updateShouldNotify(MPInheritedWidget oldWidget)=>songData!=oldWidget.songData;

}