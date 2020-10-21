import 'package:flutter/material.dart';
import 'package:schedule_of_ulstu/services/db.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.init();
  runApp(App());
}
