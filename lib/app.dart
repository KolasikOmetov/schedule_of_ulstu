import 'package:flutter/material.dart';
import 'lesson_screen/lesson_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule Of UlSTU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Color(0x7f152e),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          caption: TextStyle(fontSize: 10, color: Colors.white),
          headline1:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          headline3: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white, fontSize: 25),
          // bodyText1: TextStyle(fontSize: 17, color: Colors.deepOrangeAccent),
          // bodyText2: TextStyle(fontSize: 17, color: Colors.white),
          // button: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
      home: SafeArea(child: LessonScreen()),
    );
  }
}

// colors: #7f152e #d61800 #edae01 #e94f08
