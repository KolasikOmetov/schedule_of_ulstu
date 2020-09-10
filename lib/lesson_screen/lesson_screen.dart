import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_of_ulstu/bloc/lesson_bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';
import 'package:schedule_of_ulstu/data/repository/lessons_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'next_button.dart';
import 'progress_bar.dart';
import 'lesson_box.dart';

class LessonScreen extends StatefulWidget {
  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  double progressAnimation = 0;
  var bloc = LessonBloc();

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void setProgressTimer(double val) {
    progressAnimation = val;
  }

  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
          create: (BuildContext context) => bloc,
          child: BlocBuilder<LessonBloc, LessonState>(
            cubit: bloc,
            builder: (context, state) {
              if (state is LoadingState) {
                bloc.add(LoadingLessonEvent(LessonsRepository()));
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
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: ProgressBar(state.curScore, state.maxScore)),
                        Expanded(
                          child: LessonBox(progressAnimation, setProgressTimer),
                          flex: 6,
                        ),
                        Expanded(
                          child: NextButton(state, setProgressTimer),
                          flex: 1,
                        )
                      ],
                    ));
              } else {
                throw UnimplementedError();
              }
            },
          )),
    ));
  }
}
