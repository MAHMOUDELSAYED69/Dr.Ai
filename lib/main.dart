import 'package:dr_ai/view/app/matrial.dart';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheDataInit();
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
