import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyApiKeys {
  static String pyDrAi = dotenv.env['pyDrAi']!;
  static String googleMap = dotenv.env['mapApiKey']!;
  static String placeSuggetion = dotenv.env['placeSuggetion']!;
}
