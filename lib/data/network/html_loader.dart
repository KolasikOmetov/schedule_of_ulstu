import 'dart:io';

import 'package:http/http.dart' as http;

class HTMLLoader{

  //https://www.ulstu.ru/schedule/students/part1/raspisan.html
  //https://www.ulstu.ru/schedule/students/part1/39.html
  getResponse(String uri) async {
    return await http.Client().get(Uri.parse(uri));
  }
}