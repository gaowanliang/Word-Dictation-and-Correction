import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:word_dictation/data/common/theme.dart';
import 'package:word_dictation/modules/binding.dart';
import 'package:word_dictation/screen/main/main_screen.dart';
import 'package:word_dictation/service/storage/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Word auditory memory',
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        navigatorObservers: [
          FlutterSmartDialog.observer,
          FirebaseAnalyticsObserver(analytics: analytics)
        ],
        builder: FlutterSmartDialog.init(),
        initialBinding: HomeBinding(),
        home: MainScreen());
  }
}
