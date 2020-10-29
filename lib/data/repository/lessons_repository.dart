import 'dart:typed_data';

import 'package:schedule_of_ulstu/data/model/lesson.dart';
import 'package:schedule_of_ulstu/data/network/html_loader.dart';
import 'package:html/dom.dart';
import 'package:schedule_of_ulstu/services/db.dart';
import 'cp1251.dart';

class LessonsRepository {
  HTMLLoader _htmlLoaderGroup;
  HTMLLoader _htmlLoaderPageOfGroups;
  List<Lesson> allL = [];
  List<Element> allG;
  Future<void> _document;
  String lessonsLink;
  String baseURL = "https://www.ulstu.ru/schedule/students/part1/";
  final cp1251 = CP1251.cp1251;
  final String groupName;

  LessonsRepository(this.groupName) {
    _htmlLoaderGroup = HTMLLoader();
    _htmlLoaderPageOfGroups = HTMLLoader();
  }

  Future<List<Lesson>> getAllLessons() async {
    await _htmlLoaderPageOfGroups
        .getDocument(
            "https://www.ulstu.ru/schedule/students/part1/raspisan.html")
        .whenComplete(() {
      allG = _htmlLoaderPageOfGroups.document.getElementsByTagName("a");
      findLinkOfGroup(groupName);
    });
    print("$lessonsLink");
    _document = _htmlLoaderGroup.getDocument(lessonsLink);
    return Future.wait([_document]).then((res) {
      parseToListLessons(_htmlLoaderGroup.document);
      setId();
      putInDB();
      return allL;
    });
  }

  void putInDB() async {
    List<Lesson> allLDB = List();
    List<Map<String, dynamic>> query = List();
    try {
      query = await DB.query("lessons");
    } catch (e) {
      print(e);
    }

    for (var lesson in query) {
      allLDB.add(Lesson.fromMap(lesson));
    }
    if (allLDB.length == 0) {
      for (var lesson in allL) {
        await DB.insert("lessons", lesson);
      }
    } else {
      for (var lesson in allL) {
        await DB.update("lessons", lesson);
      }
    }
  }

  void parseToListLessons(Document r) {
    List<Element> cells = r.getElementsByTagName("td");
    for (int line = 2; line < 18; line++) {
      if (line == 9 || line == 10) continue;

      for (int cell = line * 10 + 1; cell < line * 10 + 9; cell++) {
        int column = cell % 10;
        List<String> time = cells[column + 10].text.trim().split("-");
        allL.add(Lesson(
            text: _decodeCp1251(cells[cell].text),
            timeStart: time[0],
            timeFinish: time[1]));
      }
    }
    print(allL.length);
  }

  String _decodeCp1251(String body) {
    Uint8List bytes = Uint8List.fromList(body.codeUnits);
    StringBuffer htmlBuffer = new StringBuffer();
    for (num i = 0; i < bytes.length; i++) {
      htmlBuffer.write('${cp1251[bytes[i]]}');
    }
    return htmlBuffer.toString();
  }

  void findLinkOfGroup(String s) {
    for (Element group in allG) {
      if (_decodeCp1251(group.text).contains(s)) {
        lessonsLink = baseURL + group.attributes["href"];
        return;
      }
    }
    throw ArgumentError("Выбранной вами группы нет");
  }

  void setId() {
    for (int i = 0; i < allL.length; i++) {
      allL[i].id = i;
    }
  }
}
