import 'package:flutter/material.dart';
import 'package:music/HomePage.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Music Player",
      theme: ThemeData(
        primaryColor: Color(0xFF333945),
        fontFamily: 'Bitter',
      ),
      home: HomePage(),
    );
  }
}
