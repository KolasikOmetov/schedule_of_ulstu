import 'dart:math';

import 'package:dio/dio.dart';
import 'package:schedule_of_ulstu/data/model/lesson.dart';
import 'package:schedule_of_ulstu/data/network/lessons.dart';
import 'package:schedule_of_ulstu/data/network/rest_client.dart';
import 'package:schedule_of_ulstu/data/network/result.dart';

class LessonsRepository {
  Dio _dio;
  RestClient _restClient;
  List<Lesson> allQ;
  Future<Lessons> _easyQ;
  Future<Lessons> _mediumQ;
  Future<Lessons> _hardQ;

  LessonsRepository() {
    _dio = Dio();
    _restClient = RestClient(_dio);
    _getAllL();
  }

  void _getAllL() {
    _easyQ = _restClient.getEasyLessons();
    _mediumQ = _restClient.getMediumLessons();
    _hardQ = _restClient.getHardLessons();
  }

  List<Lesson> _addToAllQ(Lessons questions) {
    List<Lesson> allQ = List<Lesson>();
    for (var item in questions.results) {
      int amountAnswers = item.incorrect_answers.length + 1;
      int rightAnswerNum = 1 + Random().nextInt(amountAnswers);
      List<String> answers = List<String>();
      for (int i = 0, bias = 0; i < amountAnswers; i++) {
        if (i == rightAnswerNum - 1) {
          answers.add(item.correct_answer);
          bias++;
        } else {
          answers.add(item.incorrect_answers[i - bias]);
        }
      }
      allQ.add(Lesson(
          text: item.question,
          answers: answers,
          difficalty: _getDifficalty(item.difficulty),
          rightAnswerNum: rightAnswerNum));
    }
    print('Length: ${allQ.length}');
    return allQ;
  }

  int _getDifficalty(Difficulty difficalty) {
    switch (difficalty) {
      case Difficulty.Easy:
        return 1;
      case Difficulty.Medium:
        return 2;
      case Difficulty.Hard:
        return 3;
    }
    return 0;
  }

  Future<List<Lesson>> getAllLessons() async {
    return await Future.wait([_easyQ, _mediumQ, _hardQ]).then((res) {
      allQ = _addToAllQ(res[0])
        ..addAll(_addToAllQ(res[1]))
        ..addAll(_addToAllQ(res[2]));
      return allQ;
    });
  }
}
