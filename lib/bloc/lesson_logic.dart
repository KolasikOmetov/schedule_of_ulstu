import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:schedule_of_ulstu/data/model/lesson.dart';
import 'package:schedule_of_ulstu/data/repository/lessons_repository.dart';

class LessonState {}

class LoadingState extends LessonState {}

class ErrorState extends LessonState {
  Exception exception;

  ErrorState(this.exception);
}

class BaseState extends LessonState {
  final UnmodifiableListView<Lesson> allQ;
  int curQuest;
  int chosen;
  int curScore;
  int get maxScore => getMaxScore();

  BaseState(this.curQuest, this.chosen, this.curScore, {@required this.allQ});

  int getMaxScore() {
    int maxScore = 0;
    for (var item in allQ) {
      maxScore += 5 * item.difficalty;
    }
    return maxScore;
  }
}

class LessonEvent {}

class LoadingLessonEvent extends LessonEvent {
  LessonsRepository repository;

  LoadingLessonEvent(this.repository);
}

class ReloadingLessonEvent extends LessonEvent {}

class RefreshLessonEvent extends LessonEvent {
  BaseState state;
  final BuildContext context;

  RefreshLessonEvent(this.context, this.state);
}

class CheckLessonEvent extends LessonEvent {
  BuildContext context;
  BaseState state;

  CheckLessonEvent(this.state, this.context);
}

class ChooseLessonEvent extends LessonEvent {
  BaseState state;
  final int chosen;

  ChooseLessonEvent(this.state, this.chosen);
}
