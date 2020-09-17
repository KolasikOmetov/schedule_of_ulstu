import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';

class MainStage extends StatefulWidget {
  final BaseState state;
  MainStage(this.state);

  @override
  _MainStageState createState() => _MainStageState();
}

class _MainStageState extends State<MainStage> {
  final pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
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
                    Text("Понедельник" + (position+1).toString()),
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
              delegate: SliverChildBuilderDelegate(
                (context, itemNum) {
                return GestureDetector(
                                  child: Container(
                    color: Colors.red,
                    child: Center(child: Text(widget.state.allL[((position+1)*8 + itemNum).toInt()].text)),
                  ),
                  onTap: (){print(((position)*8 + itemNum).toInt());},
                );
              },
              childCount: 8, 
              ))
        ]);
      },
      itemCount: 7,
    );
  }
}
