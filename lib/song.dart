import 'dart:math';
import 'package:flute_music_player/flute_music_player.dart';
class SongData
{
  List<Song> song;
  int currentSongIndex=-1;
  MusicFinder musicFinder;
  SongData(this.song){
    musicFinder=new MusicFinder();
  }
  List<Song> get songs=>song;
  int get length=>song.length;
  int get songNumber=>currentSongIndex+1;
  setCurrentIndex(int index)
  {
    currentSongIndex=index;
  }
  Song get nextSong {
    if(currentSongIndex<length)
    {
      currentSongIndex++;
    }
    if(currentSongIndex>=length) return null;
    return song[currentSongIndex];
  }
  Song get randomSong{
    Random r=new Random();
    return song[r.nextInt(song.length)];
  }
  Song get prevSong{
     if(currentSongIndex > 0)
    {
      currentSongIndex--;
    }
    if(currentSongIndex < 0) return null;
    return song[currentSongIndex];
  }
}
