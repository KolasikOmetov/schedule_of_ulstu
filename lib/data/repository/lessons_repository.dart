import 'dart:typed_data';

import 'package:schedule_of_ulstu/data/model/lesson.dart';
import 'package:schedule_of_ulstu/data/network/html_loader.dart';
import 'package:html/dom.dart';
import 'cp1251.dart';

class LessonsRepository {
  HTMLLoader _htmlLoader;
  List<Lesson> allL;
  Future<void> _document;
  final cp1251 = CP1251.cp1251;

  LessonsRepository() {
    _htmlLoader = HTMLLoader();
    _getAllL();
  }

  void _getAllL() async {
    _document = _htmlLoader
        .getDocument("https://www.ulstu.ru/schedule/students/part1/39.html");
  }

  Future<List<Lesson>> getAllLessons() async {
    return await Future.wait([_document]).then((res) {
      allL = parseToListLessons(_htmlLoader.document);
      return allL;
    });
  }

  List<Lesson> parseToListLessons(Document r) {
    List<Lesson> allL = [];
    List<Element> cells = r.getElementsByTagName("td");
    for (int line = 2; line < 18; line++) {
      if (line == 9 || line == 10) continue;

      for (int cell = line * 10 + 1; cell < line * 10 + 9; cell++) {
        int column = cell % 10;
        List<String> time = cells[column+10].text.trim().split("-");
        allL.add(Lesson(
            text: _decodeCp1251(cells[cell].text),
            timeStart: time[0],
            timeFinish: time[1]));
      }
    }
    print(allL.length);
    return allL;
  }

  String _decodeCp1251(String body) {
    Uint8List bytes = Uint8List.fromList(body.codeUnits);
    StringBuffer htmlBuffer = new StringBuffer();
    for (num i = 0; i < bytes.length; i++) {
      htmlBuffer.write('${cp1251[bytes[i]]}');
    }
    return htmlBuffer.toString();
  }
}
