import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:schedule_of_ulstu/bloc/lesson_logic.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LoadingState());

  @override
  Stream<LessonState> mapEventToState(LessonEvent event) async* {
    // LoadingLessonEvent
    if (event is LoadingLessonEvent) {
      try {
        await event.lessonsRepository.getAllLessons();
      } catch (e) {
        print(e);
        yield ErrorState(e.toString());
        return;
      }
      yield BaseState(
          allL: UnmodifiableListView(event.lessonsRepository.allL), week: 1);
    } else
    // ReloadingLessonEvent
    if (event is ReloadingLessonEvent) {
      yield LoadingState();
    } else if (event is ChangeWeekEvent) {
      int week = event.state.week == 1 ? 2 : 1;
      yield BaseState(allL: event.state.allL, week: week);
    } else {
      throw UnimplementedError();
    }
  }
}
