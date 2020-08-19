# Flute_Music_Player

A new Flutter application.

## Features

  * [x] Fetch local songs (Inbuilt Permission)
  * [x] Beautiful UI with multiple themes(Coming Soon)
  * [x] Animation
  * [x] Full Fledged Example
  * [x] play (local files)
  * [x] stop
  * [x] pause
  * [x] seek
  * [x] shuffle
  * [x] Album Art
  * [x] onComplete
  * [x] onDuration / onCurrentPosition

* Supported formats

  * [Android](https://developer.android.com/guide/topics/media/media-formats.html)


## Music Player Development Project

[Flutter Beautiful Music Player](https://github.com/surya88i/Flute-Music-Player)

### Screenshots

<img src="![Screenshot_20200819-150356](https://user-images.githubusercontent.com/51407211/90618812-17916900-e22e-11ea-93b9-1ff3d28a4515.png)
" height="300em" /> 
<img src="flute1.png" height="300em" /> <img src="flute2.png" height="300em" /> <img src="flute3.png" height="300em" /> <img src="flute4.png" height="300em" /><img src="flute5.png" height="300em" />

## Usage

To use this plugin :

* add the dependency to your [pubspec.yaml](https://github.com/iampawan/Flute-Music-Player/blob/master/example/pubspec.yaml) file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
    flute_music_player:
```

* instantiate an Music Finder instance

```dart
//...
MusicFinder audioPlayer = new MusicFinder();
//...
```

# Fetch Songs

```dart
//...
var songs = MusicFinder.allSongs();
//...
```

### play, pause , stop, seek

```dart
play() async {
  final result = await audioPlayer.play(kUrl);
  if (result == 1) setState(() => playerState = PlayerState.playing);
}

// add a isLocal parameter to play a local file
playLocal() async {
  final result = await audioPlayer.play(kUrl);
  if (result == 1) setState(() => playerState = PlayerState.playing);
}


pause() async {
  final result = await audioPlayer.pause();
  if (result == 1) setState(() => playerState = PlayerState.paused);
}

stop() async {
  final result = await audioPlayer.stop();
  if (result == 1) setState(() => playerState = PlayerState.stopped);
}

// seek 5 seconds from the beginning
audioPlayer.seek(5.0);
```

### duration, position, complete, error (temporary api)

The Dart part of the plugin listen for platform calls :

```dart
//...
audioPlayer.setDurationHandler((Duration d) => setState(() {
  duration = d;
}));

audioPlayer.setPositionHandler((Duration  p) => setState(() {
  position = p;
}));

audioPlayer.setCompletionHandler(() {
  onComplete();
  setState(() {
    position = duration;
  });
});

audioPlayer.setErrorHandler((msg) {
  print('audioPlayer error : $msg');
  setState(() {
    playerState = PlayerState.stopped;
    duration = new Duration(seconds: 0);
    position = new Duration(seconds: 0);
  });
});
```

##Credit for audioplayer plugin
[Erick Ghaumez](https://github.com/rxlabz/audioplayer)
[Detailed Example for AudioPlayer](https://github.com/rxlabz/audioplayer/blob/master/example/lib/main.dart)

## iOS

### Alert: iOS implementation

This project is not implemented for ios yet.So wait for it or if you can contribute then please do help.



