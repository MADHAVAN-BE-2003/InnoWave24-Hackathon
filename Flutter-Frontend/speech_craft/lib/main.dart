import 'package:flutter/material.dart';
import 'package:speech_craft/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              title: Text(
                'Speech Craft',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: App()),
      ),
    );
  }
}
