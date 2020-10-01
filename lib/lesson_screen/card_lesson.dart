import 'package:flutter/material.dart';

class CardLesson extends StatelessWidget {
  final String item;
  final String time;
  final int position;

  CardLesson({Key key, this.item, this.position, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmpty = item == "\n" ? true : false;
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
                          child: Container(child: Center(child: Text(time.trim()))))
                    ])),
                    Flexible(
                      flex: 4,
                      child: isEmpty
                              ? Text("Нет занятия")
                              : Text(
                                  item,
                                  // style: Theme.of(context).textTheme.headline6,
                                )),
                  ],
                ))),
      ),
    );
  }
}
