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
  final UnmodifiableListView<Lesson> allL;

  BaseState({@required this.allL});
}

class LessonEvent {}

class LoadingLessonEvent extends LessonEvent {
  LessonsRepository lessonsRepository;

  LoadingLessonEvent(this.lessonsRepository);
}

class ReloadingLessonEvent extends LessonEvent {}