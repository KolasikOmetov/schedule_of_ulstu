import 'package:schedule_of_ulstu/data/model/model.dart';

class Lesson extends Model {
  static String table = 'lessons';

  int id;
  String text;
  String timeStart;
  String timeFinish;

  Lesson({this.id, this.text, this.timeFinish, this.timeStart});

  Map<String, dynamic> toMap() {

        Map<String, dynamic> map = {
            'text': text,
            'timeFinish': timeFinish,
            'timeStart': timeStart
        };

        if (id != null) { map['id'] = id; }
        return map;
    }

    static Lesson fromMap(Map<String, dynamic> map) {
        
        return Lesson(
            id: map['id'],
            text: map['text'],
            timeStart: map['timeStart'],
            timeFinish: map['timeFinish'],
        );
    }
}