import 'package:flute_music_player/flute_music_player.dart';
import 'dart:math';

class SongData {
  List<Song> song;
  int _currentSongIndex = -1;
  MusicFinder musicFinder;
  SongData(this.song) {
    musicFinder = new MusicFinder();
  }

  List<Song> get songs => song;
  int get length => song.length;
  int get songNumber => _currentSongIndex + 1;

  setCurrentIndex(int index) {
    _currentSongIndex = index;
  }

  int get currentIndex => _currentSongIndex;

  Song get nextSong {
    if (_currentSongIndex < length) {
      _currentSongIndex++;
    }
    if (_currentSongIndex >= length) return null;
    return song[_currentSongIndex];
  }

  Song get randomSong {
    Random r = new Random();
    return song[r.nextInt(song.length)];
  }

  Song get prevSong {
    if (_currentSongIndex > 0) {
      _currentSongIndex--;
    }
    if (_currentSongIndex < 0) return null;
    return song[_currentSongIndex];
  }

  MusicFinder get audioPlayer => musicFinder;
}
