import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';
import 'package:schedule_of_ulstu/data/model/lesson.dart';
import 'package:schedule_of_ulstu/lesson_screen/card_lesson.dart';
import 'package:schedule_of_ulstu/lesson_screen/header.dart';

class MainStage extends StatefulWidget {
  final BaseState state;
  MainStage(this.state);

  @override
  _MainStageState createState() => _MainStageState();
}

class _MainStageState extends State<MainStage> {
  final pageController =
      PageController(initialPage: DateTime.now().weekday - 1);
  final daysOfWeek = const [
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
          return ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (BuildContext context, int itemNum) {
                if (itemNum == 0) {
                  return Header(
                      state: widget.state,
                      position: position,
                      daysOfWeek: daysOfWeek,
                      controller: pageController);
                }
                Lesson lesson = widget.state.allL[
                    (position * 8 + itemNum - 1 + 56 * (widget.state.week - 1))
                        .toInt()];
                if(lesson.text != "\n"){
                return GestureDetector(
                  child: CardLesson(
                    position: itemNum,
                    lesson: lesson,
                  ),
                  onTap: () {
                    print(((position + 1) * 8 +
                            itemNum -
                            1 +
                            56 * (widget.state.week - 1))
                        .toInt());
                  },
                );
                }
                else {
                  return Container();
                }
              });
        });
  }
}
