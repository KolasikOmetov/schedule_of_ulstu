import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LoadingState());

  @override
  Stream<LessonState> mapEventToState(LessonEvent event) async* {
    // LoadingLessonEvent
    if (event is LoadingLessonEvent) {
      try {
        await event.repository.getAllLessons();
      } catch (e) {
        yield ErrorState(e);
        return;
      }
      yield BaseState(0, -1, 0,
          allQ: UnmodifiableListView(event.repository.allQ));
    } else
    // ReloadingLessonEvent
    if (event is ReloadingLessonEvent) {
      yield LoadingState();
    } else
    // RefreshLessonEvent
    if (event is RefreshLessonEvent) {
      BaseState state = event.state;
      if (state.curQuest < state.allQ.length - 1) {
        yield BaseState(state.curQuest + 1, -1, state.curScore,
            allQ: state.allQ);
      } else {
        // Navigator.of(event.context).push(
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           ScoreScreen(state.curScore, state.maxScore)),
        // );
      }
    } else
    // CheckLessonEvent
    if (event is CheckLessonEvent) {
      var state = event.state;
      if (state.chosen + 1 == state.allQ[state.curQuest].rightAnswerNum) {
        state.curScore = state.curScore + state.allQ[state.curQuest].difficalty * 5;
      }
      if (state.curQuest < state.allQ.length - 1) {
        yield BaseState(state.curQuest + 1, -1, state.curScore,
            allQ: state.allQ);
      } else {
        // Navigator.of(event.context).push(
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           ScoreScreen(state.curScore, state.maxScore)),
        // );
      }
    } else
    // ChooseLessonEvent
    if (event is ChooseLessonEvent) {
      var state = event.state;
      print("ChooseLessonEvent");
      yield BaseState(state.curQuest, event.chosen, state.curScore,
          allQ: state.allQ);
    } else {
      throw UnimplementedError();
    }
  }
}
