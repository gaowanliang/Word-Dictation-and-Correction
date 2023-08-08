import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/storage/service.dart';

class HomeController extends GetxController {
  HomeController();
  final _storage = Get.find<StorageService>();
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
  final favoritesWordList = <String>[].obs;

  void saveWord(String data, int mode, int? correctTimes, bool? isBlur) {
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

  saveSessionData(bool speakAllowed, bool wordBlur, bool isFavorite,
      String previousWordInfo) {
    _storage.writeSessionData(SessionData(
        wordList,
        wordMeaningList,
        mode.value,
        isBlur.value,
        correctTimes.value,
        remainInputTimes.value,
        separator.value,
        ttsLanguage.value,
        wrongWordList,
        favoritesWordList,
        speakAllowed,
        wordBlur,
        isFavorite,
        previousWordInfo));
    // print(_storage.readSessionData().toJson());
  }

  SessionData readSessionData() {
    var sessionData = _storage.readSessionData();
    if (sessionData.wordList.isNotEmpty) {
      wordList.value = sessionData.wordList;
      wordMeaningList.value = sessionData.wordMeaningList;
      mode.value = sessionData.mode;
      isBlur.value = sessionData.isBlur;
      correctTimes.value = sessionData.correctTimes;
      remainInputTimes.value = sessionData.remainInputTimes;
      separator.value = sessionData.separator;
      ttsLanguage.value = sessionData.ttsLanguage;
      wrongWordList.value = sessionData.wrongWordList;
      favoritesWordList.value = sessionData.favoritesWordList;
      return sessionData;
    }

    return SessionData(
        [], [], 0, false, 0, 0, " ", "en-US", [], [], false, false, false, " ");
  }

  void clearSessionData() {
    _storage.clearSessionData();
  }
}
