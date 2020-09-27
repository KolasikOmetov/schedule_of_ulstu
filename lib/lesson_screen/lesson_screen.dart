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

  void dispose(){
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
                bloc.add(
                    LoadingLessonEvent(LessonsRepository()));
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.yellow));
              } else if (state is ErrorState) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Network error!"),
                    Text(state.exception.toString()),
                    GestureDetector(
                      child: Text(
                        "Try again",
                        style: TextStyle(
                            backgroundColor: Theme.of(context).accentColor),
                      ),
                      onTap: () => bloc.add(ReloadingLessonEvent()),
                    )
                  ],
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
