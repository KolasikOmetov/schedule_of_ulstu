import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';

class ErrorMessage extends StatelessWidget {
  final state;

  const ErrorMessage({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: BoxConstraints.loose(Size(
              MediaQuery.of(context).size.width * 0.80,
              MediaQuery.of(context).size.height * 0.80)),
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.exception,
                textAlign: TextAlign.center,
              ),
              Icon(Icons.warning, size: 50),
              Text(
                "Возможно, у вас отключен интернет...\nИначе произошла ошибка, несвязанная с работой приложения.",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Открыть сохранённое расписание",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                onTap: () => BlocProvider.of<LessonBloc>(context)
                    .add(LoadingLessonsFromDBEvent()),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: null),
                      IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () => BlocProvider.of<LessonBloc>(context)
                              .add(ReloadingLessonEvent())),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
