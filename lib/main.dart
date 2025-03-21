import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_work_mgmt_app/app.dart';
import 'package:intl/date_symbol_data_local.dart';

void run() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('vi', null);
  await dotenv.load(fileName: ".env");

  runApp(const App());
}

void main() {
  run();
}
