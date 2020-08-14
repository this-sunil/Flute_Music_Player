import 'dart:async';
import 'dart:io';
import 'package:cycles/song.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:volume/volume.dart';
class NowPlaying extends StatefulWidget {
  final SongData songData;
  final Song song;
  NowPlaying(this.songData,this.song);
  @override
  _NowPlayingState createState() => _NowPlayingState();
}
enum PlayerState {stopped,playing,paused}
class _NowPlayingState extends State<NowPlaying> with SingleTickerProviderStateMixin{
  Song song;
  Animation animation;
  AnimationController animationController;
  MusicFinder musicFinder;
  Duration duration=Duration();
  Duration position=Duration();
  PlayerState playerState=PlayerState.stopped;
  bool flag,flags;bool on;bool ismuted;
  int maxVol, currentVol;
  List<BoxShadow> shadowList = [
    BoxShadow(
      blurRadius: 3.0,
      color: Colors.grey[300],
      offset: Offset(3, 3),
    ),
  ];
 
  get isPlaying=>playerState==PlayerState.playing;
  get isPaused=>playerState==PlayerState.paused;
  IconData one;
  Color ones;
  double value=0.0;
  int playerId;
  int quantity=1;
  @override
  void initState() { 
    super.initState();
    flags=false;
    flag=false;
    on=false;
    ismuted=false;
    animationController=AnimationController(vsync: this,animationBehavior: AnimationBehavior.preserve);
    animation=Tween<double>(begin: 0.0,end: 3.0).animate(CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
    initPlayer();
    refresh();
    initPlatformState();
  
  }
  
 
  onComplete(){
    setState(()=>playerState=PlayerState.stopped);
  }
  
  refresh() {
    setState(() {
      one = Icons.favorite_border;
      ones = Colors.teal;
    });
  }
  
 Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }
adjustQuantity(press){
  switch(press)
  {
    case 'MINUS':setState(() {
      if(quantity!=0)
      {
        setVol(quantity--);
      }
    });
    return;
    case 'PLUS':setState(() {
      setVol(quantity++);
    });
    return;
  }
}
  updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
  }

  setVol(int i) async {
    await Volume.setVol(i, showVolumeUI: ShowVolumeUI.SHOW);
  }
  Future play(Song s) async{
    if(s!=null)
    {
      final result=await musicFinder.play(s.uri,isLocal: true);
      if(result==1)setState(() {
        playerState=PlayerState.playing;
        song=s;
      });
    }
  }

Future pause() async {
    final result = await musicFinder.pause();
    if (result == 1) setState(() => playerState = PlayerState.paused);
  }

  Future stop() async{
      final result=await musicFinder.stop();
      if(result==1)setState(() {
        playerState=PlayerState.stopped;
        position=new Duration();
      });
  }

  Future next(SongData s) async{
    stop();
    setState(() {
     play(s.nextSong);

    });
  }
  Future prev(SongData s) async{
    stop();
    setState(() {
     play(s.prevSong);
    });
  }
  Future mute(bool muted) async {
    final result = await musicFinder.mute(muted);
    if (result == 1)
      setState(() {
        ismuted = muted;
      });
  }
  @override
  void dispose() { 
    musicFinder.stop();
    super.dispose();
  }
 
  initPlayer() async{
   setState(() {
    if(musicFinder==null)
    {
      musicFinder=widget.songData.musicFinder;
    }
    setState(() {
      song=widget.song;
    });
      musicFinder.setDurationHandler((d) {
      setState(() {
        duration=d;
      });
  });
  musicFinder.setPositionHandler((p) {
      setState(() {
        position=p;
      });
  });

  musicFinder.setCompletionHandler(() { 
    onComplete();
    setState(() {
     position = duration;
      playerState = PlayerState.stopped;
    });
  });
  musicFinder.setErrorHandler((message) { 
    setState(() {
      playerState=PlayerState.stopped;
      duration=Duration(seconds: 0);
      position=Duration(seconds: 0);
    });
  }); 
  musicFinder.durationHandler.call(duration);
  musicFinder.positionHandler.call(position);
  });
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Music Player"),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
         SizedBox(height:40),
          Hero(
              tag: song.title,
              child: Stack(
              alignment: Alignment.center,
                children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowList,
                    shape: BoxShape.circle,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Center(
                      child: song.albumArt==null?Icon(Icons.music_note,size:80):ClipOval(child: Image.file(File.fromUri(Uri.parse(song.albumArt)),fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Positioned(
                      right: 90,
                      bottom:0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: shadowList,
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: IconButton(
                                icon: Icon(one, color: ones),
                                onPressed: () {
                                  setState(() {
                                    one = flag
                                        ? Icons.favorite
                                        : Icons.favorite_border;
                                    ones = flag ? Colors.red : Colors.teal;
                                    flag = !flag;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),

        
          SizedBox(
            height: 30,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(song.title,textAlign: TextAlign.justify,style: TextStyle(fontSize: 16)),
                SizedBox(height:10),
                Text(song.artist,style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          
          SizedBox(
            height: 30,
          ),
          Slider(
            value: position?.inSeconds?.toDouble() ?? 0.0,
            min: 0.0,
            max:duration.inSeconds.toDouble(),
            activeColor: Colors.teal,
            onChanged: (double value){
              setState(() {
                musicFinder.seek(value.roundToDouble());
              });
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(Duration(seconds: position?.inSeconds?.toInt() ?? 0)
                            .toString()
                            .split('.')[0],),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(Duration(seconds: duration?.inSeconds?.toInt() ?? 0)
                            .toString()
                            .split('.')[0]),
            ),
          ],
        ),
        SizedBox(height:40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: 60,
                height:60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  shape: BoxShape.circle,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left,color: Colors.teal),
                    onPressed: () {
                      setState(() {
                        prev(widget.songData);
                      });
                    },
                  ),
                ),
              ),

              Container(
                width: 60,
                height:60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  shape: BoxShape.circle,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.volume_off,color: Colors.teal),
                    onPressed: () {
                      setState(() {
                        adjustQuantity('MINUS');
                      });
                    },
                  ),
                ),
              ),


              Container(
                width: 60,
                height:60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  shape: BoxShape.circle,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: Icon(isPlaying?Icons.pause_circle_outline:Icons.play_circle_outline,color: Colors.teal),
                    onPressed: () {
                      setState(() {
                        isPlaying?stop():play(widget.song);
                      });
                    },
                  ),
                ),
              ),
              Container(
                width: 60,
                height:60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  shape: BoxShape.circle,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.volume_up,color: Colors.teal),
                    onPressed: () {
                     setState(() {
                       adjustQuantity('PLUS');
                     });
                    },
                    
                  ),
                ),
              ),
              Container(
                width: 60,
                height:60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  shape: BoxShape.circle,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right,color: Colors.teal),
                    onPressed: () {
                      setState(() {
                       next(widget.songData);
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      ],
     ),
    );
  }
}
