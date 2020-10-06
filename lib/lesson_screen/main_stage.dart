import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/bloc/lesson_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';
import 'package:schedule_of_ulstu/lesson_screen/card_lesson.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainStage extends StatefulWidget {
  final BaseState state;
  MainStage(this.state);

  @override
  _MainStageState createState() => _MainStageState();
}

class _MainStageState extends State<MainStage> {
  final pageController =
      PageController(initialPage: DateTime.now().weekday - 1);
  final daysOfWeek = [
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота",
    "Воскресенье",
  ];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: daysOfWeek.length,
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
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          BlocProvider.of<LessonBloc>(context)
                              .add(ReloadingLessonEvent());
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.navigate_before),
                        onPressed: () {
                          BlocProvider.of<LessonBloc>(context)
                              .add(ChangeWeekEvent(widget.state));
                        }),
                    widget.state.week == 1
                        ? Text("1-я неделя")
                        : Text("2-я неделя"),
                    IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () {
                          BlocProvider.of<LessonBloc>(context)
                              .add(ChangeWeekEvent(widget.state));
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.navigate_before),
                        onPressed: () {
                          if (position == 0) {
                            pageController.jumpToPage(daysOfWeek.length - 1);
                            BlocProvider.of<LessonBloc>(context)
                                .add(ChangeWeekEvent(widget.state));
                          } else {
                            pageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                        }),
                    Text(daysOfWeek[position]),
                    IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () {
                          if (position == daysOfWeek.length - 1) {
                            pageController.jumpToPage(0);
                            BlocProvider.of<LessonBloc>(context)
                                .add(ChangeWeekEvent(widget.state));
                          } else {
                            pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                        }),
                  ],
                ),
              ],
            ),
            expandedHeight: 200,
            backgroundColor: Color(0xE94F08),
          ),
          SliverFixedExtentList(
              itemExtent: 170,
              delegate: SliverChildBuilderDelegate(
                (context, itemNum) {
                  String item = widget
                      .state
                      .allL[((position + 1) * 8 +
                              itemNum +
                              56 * (widget.state.week - 1))
                          .toInt()]
                      .text;
                  String time = widget.state.allL[itemNum].text;
                  // if(item != "\n"){
                  return GestureDetector(
                    child: CardLesson(
                      position: itemNum + 1,
                      item: item,
                      time: time,
                    ),
                    onTap: () {
                      print(((position + 1) * 8 +
                              itemNum +
                              56 * (widget.state.week - 1))
                          .toInt());
                    },
                  );
                  // }
                  // else {
                  //   return Container(child: Text("data"),);
                  // }
                },
                childCount: 8,
              ))
        ]);
      },
    );
  }
}
