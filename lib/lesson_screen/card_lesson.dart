import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/data/model/lesson.dart';

class CardLesson extends StatelessWidget {
  final Lesson lesson;
  final int position;

  CardLesson({Key key, this.lesson, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmpty = lesson.text == "\n" ? true : false;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            color: isEmpty ? Colors.grey : Theme.of(context).cardColor,
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Flexible(
                        child: Row(children: [
                      Expanded(
                          child: Container(
                              child: CircleAvatar(
                                  child: Center(
                                      child: Text(
                        position.toString(),
                      ))))),
                      Expanded(
                          flex: 9,
                          child: Container(child: Center(child: Text("${lesson.timeStart}-${lesson.timeFinish}"))))
                    ])),
                    Flexible(
                      flex: 4,
                      child: isEmpty
                              ? Text("Нет занятия")
                              : Text(
                                  lesson.text,
                                  // style: Theme.of(context).textTheme.headline6,
                                )),
                  ],
                ))),
      ),
    );
  }
}
