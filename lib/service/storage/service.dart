import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SessionData {
  List<String> wordList;
  List<String> wordMeaningList;
  int mode;
  bool isBlur;
  int correctTimes;
  int remainInputTimes;
  String separator;
  String ttsLanguage;
  List<String> wrongWordList;
  List<String> favoritesWordList;
  bool speakAllowed;
  bool wordBlur;
  bool isFavorite;
  String previousWordInfo;
  SessionData(
      this.wordList,
      this.wordMeaningList,
      this.mode,
      this.isBlur,
      this.correctTimes,
      this.remainInputTimes,
      this.separator,
      this.ttsLanguage,
      this.wrongWordList,
      this.favoritesWordList,
      this.speakAllowed,
      this.wordBlur,
      this.isFavorite,
      this.previousWordInfo);

  Map<String, dynamic> toJson() {
    return {
      "wordList": wordList,
      "wordMeaningList": wordMeaningList,
      "mode": mode,
      "isBlur": isBlur,
      "correctTimes": correctTimes,
      "remainInputTimes": remainInputTimes,
      "separator": separator,
      "ttsLanguage": ttsLanguage,
      "wrongWordList": wrongWordList,
      "favoritesWordList": favoritesWordList,
      "speakAllowed": speakAllowed,
      "wordBlur": wordBlur,
      "isFavorite": isFavorite,
      "previousWordInfo": previousWordInfo,
    };
  }

  bool wordListIsNotEmpty() {
    return wordList.isNotEmpty;
  }
}

class WordInfo {
  String word;
  bool isWord;
  bool isSelect;

  WordInfo(this.word, this.isWord, this.isSelect);
  Map<String, dynamic> toJson() {
    return {
      "word": word,
      "isWord": isWord,
      "isSelect": isSelect,
    };
  }
}

class ListeningInfo {
  bool isShowText;
  bool isUsuallyUsingWordsNeedVisible;
  List<WordInfo> words;
  ListeningInfo(
      this.isShowText, this.isUsuallyUsingWordsNeedVisible, this.words);
  Map<String, dynamic> toJson() {
    return {
      "isShowText": isShowText,
      "isUsuallyUsingWordsNeedVisible": isUsuallyUsingWordsNeedVisible,
      "words": words.map((e) => e.toJson()).toList(),
    };
  }

  bool wordsIsNotEmpty() {
    return words.isNotEmpty;
  }
}

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    //await _box.write(taskKey, []);
    await _box.writeIfNull(
        "sessionData",
        SessionData([], [], 0, false, 0, 0, " ", "en-US", [], [], false, false,
            false, " "));
    await _box.writeIfNull("ListeningInfo", ListeningInfo(false, false, []));
    return this;
  }

  SessionData readSessionData() {
    final json = _box.read("sessionData");
    if (json is SessionData) {
      if (json.wordListIsNotEmpty()) {
        return json;
      } else {
        return SessionData([], [], 0, false, 0, 0, " ", "en-US", [], [], false,
            false, false, " ");
      }
    } else if (json is Map) {
      if (json.containsKey('wordList') && json['wordList'].isEmpty) {
        return SessionData([], [], 0, false, 0, 0, " ", "en-US", [], [], false,
            false, false, " ");
      }

      return SessionData(
          List<String>.from(json['wordList']),
          List<String>.from(json['wordMeaningList']),
          json["mode"],
          json["isBlur"],
          json["correctTimes"],
          json["remainInputTimes"],
          json["separator"],
          json["ttsLanguage"],
          List<String>.from(json['wrongWordList']),
          List<String>.from(json['favoritesWordList']),
          json["speakAllowed"],
          json["wordBlur"],
          json["isFavorite"],
          json["previousWordInfo"]);
    }
    return SessionData(
        [], [], 0, false, 0, 0, " ", "en-US", [], [], false, false, false, " ");
  }

  void writeSessionData(SessionData value) async {
    await _box.write("sessionData", value);
  }

  void clearSessionData() async {
    await _box.write(
        "sessionData",
        SessionData([], [], 0, false, 0, 0, " ", "en-US", [], [], false, false,
            false, " "));
  }

  ListeningInfo readListeningInfo() {
    final json = _box.read("ListeningInfo");
    print(json.runtimeType);
    if (json is ListeningInfo) {
      if (json.wordsIsNotEmpty()) {
        return json;
      } else {
        return ListeningInfo(false, false, []);
      }
    } else if (json is Map) {
      if (json.containsKey('words') && json['words'].isEmpty) {
        return ListeningInfo(false, false, []);
      }
      List<WordInfo> words = [];

      for (var item in json['words']) {
        words.add(WordInfo(item['word'], item['isWord'], item['isSelect']));
      }
      return ListeningInfo(
          json["isShowText"], json["isUsuallyUsingWordsNeedVisible"], words);
    }
    return ListeningInfo(false, false, []);
  }

  void writeListeningInfo(ListeningInfo value) async {
    await _box.write("ListeningInfo", value);
  }

  void clearListeningInfo() async {
    await _box.write("ListeningInfo", ListeningInfo(false, false, []));
  }
}
