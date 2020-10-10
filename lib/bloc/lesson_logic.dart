import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:schedule_of_ulstu/data/model/lesson.dart';
import 'package:schedule_of_ulstu/data/repository/lessons_repository.dart';

class LessonState {}

class LoadingState extends LessonState {}

class ErrorState extends LessonState {
  String exception;

  ErrorState(this.exception);
}

class BaseState extends LessonState {
  final UnmodifiableListView<Lesson> allL;
  final int week;

  BaseState({@required this.allL, this.week});
}

class LessonEvent {}

class LoadingLessonEvent extends LessonEvent {
  LessonsRepository lessonsRepository;

  LoadingLessonEvent(this.lessonsRepository);
}

class ChangeWeekEvent extends LessonEvent {
  BaseState state;

  ChangeWeekEvent(this.state);
}

class ReloadingLessonEvent extends LessonEvent {}