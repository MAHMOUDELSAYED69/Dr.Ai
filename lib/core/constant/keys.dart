import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyApiKeys {
  static dynamic pyDrAi = dotenv.env['pyDrAi'];
  static String? googleMap = dotenv.env['mapApiKey'];
}
