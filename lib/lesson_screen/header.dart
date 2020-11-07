import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/bloc/lesson_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatefulWidget {
  final state;
  final position;
  final controller;
  final daysOfWeek;

  const Header(
      {Key key, this.state, this.position, this.daysOfWeek, this.controller})
      : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
              Text("ПИбд-21", style: Theme.of(context).textTheme.headline5),
              IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
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
                  icon: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    BlocProvider.of<LessonBloc>(context)
                        .add(ChangeWeekEvent(widget.state));
                  }),
              Text(widget.state.week == 1 ? "1-я неделя" : "2-я неделя",
                  style: Theme.of(context).textTheme.headline5),
              IconButton(
                  icon: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
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
                  icon: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (widget.position == 0) {
                      widget.controller
                          .jumpToPage(widget.daysOfWeek.length - 1);
                      BlocProvider.of<LessonBloc>(context)
                          .add(ChangeWeekEvent(widget.state));
                    } else {
                      widget.controller.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }
                  }),
              Text(widget.daysOfWeek[widget.position],
                  style: Theme.of(context).textTheme.headline5),
              IconButton(
                  icon: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
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
      ),
    );
  }
}
