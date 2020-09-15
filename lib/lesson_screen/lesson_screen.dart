import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LessonScreen extends StatefulWidget {
  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final pageController = PageController(initialPage: 1);

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, position) {
          return CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              floating: true,
              toolbarHeight: 150,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                      Text("ПИбд-21"),
                      IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.navigate_before), onPressed: () {}),
                      Text("1-я неделя"),
                      IconButton(
                          icon: Icon(Icons.navigate_next), onPressed: () {}),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.navigate_before), onPressed: () {}),
                      Text("Понедельник"),
                      IconButton(
                          icon: Icon(Icons.navigate_next), onPressed: () {}),
                    ],
                  ),
                ],
              ),
              expandedHeight: 200,
              backgroundColor: Color(0xE94F08),
            ),
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate(
                [
                  Container(color: Colors.red),
                  Container(color: Colors.purple),
                  Container(color: Colors.green),
                  Container(color: Colors.orange),
                  Container(color: Colors.yellow),
                  Container(color: Colors.pink),
                ],
              ),
            )
          ]);
        },
        itemCount: 7,
      ),
    );
  }
}
