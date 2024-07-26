import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiUrlManager {
  ApiUrlManager._();
  static String pyDrAi = dotenv.env['pyDrAi']!;
  static String googleMapApiKey = dotenv.env['mapApiKey']!;
  static String placeSuggetion = dotenv.env['placeSuggetionBaseUrl']!;
  static String placeLocation = dotenv.env['placeLocationBaseUrl']!;
  static String directions = dotenv.env['placedirectionsBaseUrl']!;
  static String nearestHospital = dotenv.env['nearestHospitalBaseUrl']!;
  static String generativeModelApiKey = dotenv.env['generativeModelApiKey']!;
  static String generativeModelVersion = dotenv.env['generativeModelVersion']!;
}
