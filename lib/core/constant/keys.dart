import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyApiKeys {
  static const pyDrAi = "https://doctorai.pythonanywhere.com/myapp/api/";
  static String? googleMap = dotenv.env['mapApiKey'];
}
