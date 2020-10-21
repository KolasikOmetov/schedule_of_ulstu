import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class HTMLLoader {
  Document document;
  Future<void> getDocument(String uri) async {
    var response = await http.Client().get(Uri.parse(uri));
    if (response.statusCode == 200) {
      document = parse(response.body);
    } else {
      throw Exception();
    }
  }
}
