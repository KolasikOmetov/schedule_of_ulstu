import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';
import 'package:schedule_of_ulstu/data/network/html_loader.dart';
import 'package:schedule_of_ulstu/data/repository/lessons_repository.dart';
import 'package:schedule_of_ulstu/lesson_screen/main_stage.dart';

class LessonScreen extends StatefulWidget {
  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final htmlLoader = HTMLLoader();
  var bloc = LessonBloc();

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: BlocProvider(
              create: (BuildContext context) => bloc,
              child: BlocBuilder<LessonBloc, LessonState>(
                cubit: bloc,
                builder: (context, state) {
                  if (state is LoadingState) {
                    bloc.add(LoadingLessonEvent(LessonsRepository("ПИбд-21")));
                    return Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.yellow));
                  } else if (state is ErrorState) {
                    return Center(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(state.exception),
                          GestureDetector(
                            child: Container(
                              color: Theme.of(context).accentColor,
                              child: Text(
                                "Try again",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            onTap: () => bloc.add(ReloadingLessonEvent()),
                          )
                      ],
                    ),
                        ));
                  } else if (state is BaseState) {
                    return MainStage(state);
                  } else {
                    throw UnimplementedError();
                  }
                },
              )),
        ));
  }
}
