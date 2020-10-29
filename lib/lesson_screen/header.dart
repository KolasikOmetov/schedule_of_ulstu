import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/bloc/lesson_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatefulWidget {
  final state;
  final position;
  final controller;
  final daysOfWeek;

  const Header({Key key, this.state, this.position, this.daysOfWeek, this.controller}) : super(key: key);
  
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
            widget.state.week == 1 ? Text("1-я неделя") : Text("2-я неделя"),
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
                  if (widget.position == 0) {
                    widget.controller.jumpToPage(widget.daysOfWeek.length - 1);
                    BlocProvider.of<LessonBloc>(context)
                        .add(ChangeWeekEvent(widget.state));
                  } else {
                    widget.controller.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  }
                }),
            Text(widget.daysOfWeek[widget.position]),
            IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: () {
                  if (widget.position == widget.daysOfWeek.length - 1) {
                    widget.controller.jumpToPage(0);
                    BlocProvider.of<LessonBloc>(context)
                        .add(ChangeWeekEvent(widget.state));
                  } else {
                    widget.controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  }
                }),
          ],
        ),
      ],
    );
  }
}
