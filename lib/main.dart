import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:word_dictation/data/common/theme.dart';
import 'package:word_dictation/modules/binding.dart';
import 'package:word_dictation/screen/main/main_screen.dart';
import 'package:word_dictation/service/storage/service.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Word auditory memory',
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        initialBinding: HomeBinding(),
        home: MainScreen());
  }
}


