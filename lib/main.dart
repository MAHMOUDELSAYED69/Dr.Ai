import 'package:dr_ai/data/service/api/place_suggetion.dart';
import 'package:dr_ai/view/app/matrial.dart';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheDataInit();
  runApp(const MyApp());

}
