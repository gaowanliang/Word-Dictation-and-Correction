import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();
  final formKey = GlobalKey<FormState>();
  final wordList = <String>[].obs;
  final wordMeaningList = <String>[].obs;
  final wordAndMeaningText = ''.obs;
  final mode = 0.obs; // 0 代表 未选择，1代表改错模式，2代表听写模式
  final isBlur = false.obs;
  final correctTimes = 0.obs;
  final remainInputTimes = 0.obs;
  final separator = '\t'.obs;
  final ttsLanguages = <String>[].obs;
  final ttsLanguage = 'en-GB'.obs;
  final wrongWordList = <String>[].obs;
  final FavoritesWordList = <String>[].obs;

  saveWord(String data, int mode, int? correctTimes, bool? isBlur) {
    wordAndMeaningText.value = data;
    for (var item in data.split('\n')) {
      // 首先去掉首尾的空格
      item = item.trim();
      // 如果是空行，就跳过
      if (item.isEmpty) continue;

      var wordAndMeaning = item.split(separator.value);
      wordList.add(wordAndMeaning[0]);
      wordMeaningList.add(wordAndMeaning[1]);
    }

    this.mode.value = mode;
    if (mode == 1) {
      this.correctTimes.value = correctTimes ?? 1;
      remainInputTimes.value = correctTimes ?? 1;
      this.isBlur.value = isBlur ?? false;
    } else if (mode == 2) {
      remainInputTimes.value = 1;
      this.correctTimes.value = 1;
    }
  }
}
