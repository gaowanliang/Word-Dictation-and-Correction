import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:word_dictation/modules/controller.dart';
import 'package:word_dictation/screen/collection/favorites_screen.dart';
import 'package:word_dictation/screen/setting/setting_screen.dart';
import 'package:word_dictation/screen/summary/summary_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum TtsState { playing, stopped, paused, continued }

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool keyboardVisible = false;
  final homeCtrl = Get.find<HomeController>();
  final speakAllowed = true.obs;
  final wordBlur = false.obs;

  final _formKey = GlobalKey<FormState>();
  final _wordInputController = TextEditingController();
  var focusNode = FocusNode();

  @override
  initState() {
    super.initState();
    flutterTts.setLanguage("en-GB");
    _setAwaitOptions();
    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final mediaQueryData = MediaQuery.of(context);
    final keyboardHeight = mediaQueryData.viewInsets.bottom;
    setState(() {
      keyboardVisible = keyboardHeight > 0;
    });
    if (keyboardHeight == 0) {
      setState(() {
        keyboardVisible = false;
      });
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future _speak(String text) async {
    // await _stop();
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future<dynamic> _getLanguages() async {
    var test = await flutterTts.getLanguages;
    // print(test);
    List<String> languages = [];
    for (var i = 0; i < test.length; i++) {
      languages.add(test[i].toString());
    }
    homeCtrl.ttsLanguages.value = languages;
  }

  void _submitForm() {
    if (_wordInputController.text == homeCtrl.wordList[0]) {
      if (homeCtrl.remainInputTimes.value == 1) {
        homeCtrl.wordList.removeAt(0);
        homeCtrl.wordMeaningList.removeAt(0);
        homeCtrl.remainInputTimes.value = homeCtrl.correctTimes.value;
        _wordInputController.clear();
        _speak(homeCtrl.wordList[0]);
        FocusScope.of(context).requestFocus(focusNode);
        wordBlur.value = homeCtrl.isBlur.value ? true : false;
        speakAllowed.value = true;
        return;
      }

      if (!homeCtrl.isBlur.value || (homeCtrl.isBlur.value && wordBlur.value)) {
        homeCtrl.remainInputTimes.value--;
      }
      wordBlur.value = homeCtrl.isBlur.value ? true : false;
      _wordInputController.clear();
      FocusScope.of(context).requestFocus(focusNode);

      _speak(homeCtrl.wordList[0]);
    } else {
      switch (_wordInputController.text) {
        case "...":
          if (homeCtrl.FavoritesWordList.contains(
              "${homeCtrl.wordList[0]} ${homeCtrl.wordMeaningList[0]}")) {
            SmartDialog.showToast("This word is already in the Favorites list");
          } else {
            SmartDialog.showToast(
                "Successfully collected, click on the \"star\" icon in the upper right corner to view");

            homeCtrl.FavoritesWordList.add(
                "${homeCtrl.wordList[0]}${homeCtrl.separator.value}${homeCtrl.wordMeaningList[0]}");
          }
          break;
        case "":
          SmartDialog.showToast('Please enter the word');
          break;
        default:
          wordBlur.value = false;
          SmartDialog.showToast('Wrong answer, please try again');
      }

      _wordInputController.clear();
      FocusScope.of(context).requestFocus(focusNode);
      _speak(homeCtrl.wordList[0]);
    }
  }

  void _dictationMode() {
    if (_wordInputController.text == "") {
      SmartDialog.showToast('Please enter the word');
      return;
    }
    if (_wordInputController.text == homeCtrl.wordList[0]) {
      // SmartDialog.showToast('Correct answer');
    } else {
      SmartDialog.showToast('Wrong answer');
      homeCtrl.wrongWordList.add(homeCtrl.wordList[0]);
    }
    _wordInputController.clear();
    FocusScope.of(context).requestFocus(focusNode);
    homeCtrl.wordList.removeAt(0);
    homeCtrl.wordMeaningList.removeAt(0);
    _wordInputController.clear();
    if (homeCtrl.wordList.isEmpty) {
      var wrongWordListText = homeCtrl.wrongWordList.join('\n');
      Get.to(() => SummaryScreen(
            text: wrongWordListText,
          ));
      return;
    }

    _speak(homeCtrl.wordList[0]);
  }

  final Uri _url =
      Uri.parse('https://github.com/gaowanliang/Word-Dictation-and-Correction');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    _getLanguages();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        title: const Text(''),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _launchUrl();
          },
          icon: SizedBox(
            width: 30,
            height: 30,
            child: SvgPicture.asset(
              "image/github.svg",
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FavoritesScreen(
                      text: homeCtrl.FavoritesWordList.join('\n'),
                    ));
              },
              icon: Icon(Icons.star_rate_outlined)),
          IconButton(
              onPressed: () {
                Get.to(() => SettingScreen());
              },
              icon: Icon(Icons.settings)),
        ],
        elevation: 4,
      ),
      body: Obx(() {
        flutterTts.setLanguage(homeCtrl.ttsLanguage.value);
        if (homeCtrl.wordList.isNotEmpty && speakAllowed.value) {
          _speak(homeCtrl.wordList[0]);
          speakAllowed.value = false;
          wordBlur.value = homeCtrl.isBlur.value;
        }
        return homeCtrl.wordList.isNotEmpty
            ? Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          MediaQuery.of(context).size.width >
                                  MediaQuery.of(context).size.height
                              ? MediaQuery.of(context).size.width *
                                  (keyboardVisible ? 0.25 : 0.13)
                              : MediaQuery.of(context).size.height *
                                  (keyboardVisible ? 0.3 : 0.15),
                          0,
                          0),
                      child: homeCtrl.mode.value == 1
                          ? Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 0, 30, 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _speak(homeCtrl.wordList[0]);
                                            },
                                            child: Text(
                                              homeCtrl.wordList[0],
                                              style: GoogleFonts.oxygen(
                                                textStyle: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width >
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.1
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.1,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      homeCtrl.wordMeaningList[0],
                                      style: GoogleFonts.notoSans(
                                          textStyle: TextStyle(fontSize: 25)),
                                    ),
                                  ],
                                ),
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: wordBlur.value ? 50.0 : 0.0,
                                    sigmaY: wordBlur.value ? 50.0 : 0.0,
                                  ),
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                )
                              ],
                            )
                          : IconButton(
                              onPressed: () {
                                _speak(homeCtrl.wordList[0]);
                              },
                              icon: const Icon(Icons.record_voice_over)),
                    ),
                    Expanded(child: Container()),
                    Form(
                      key: homeCtrl.formKey,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              obscureText: false,
                              focusNode: focusNode,
                              controller: _wordInputController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the word';
                                }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                homeCtrl.mode.value == 1
                                    ? _submitForm()
                                    : _dictationMode();
                              },
                              decoration: InputDecoration(
                                labelText: 'Enter the word',
                                labelStyle: GoogleFonts.notoSans(
                                    textStyle: const TextStyle(fontSize: 20)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(fontSize: 20)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: SizedBox(
                                width: 80,
                                child: IconButton(
                                  onPressed: () {
                                    homeCtrl.mode.value == 1
                                        ? _submitForm()
                                        : _dictationMode();
                                  },
                                  icon: Icon(Icons.check),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        10,
                        30,
                        0,
                        MediaQuery.of(context).size.width >
                                MediaQuery.of(context).size.height
                            ? MediaQuery.of(context).size.height * 0.05
                            : MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Tooltip(
                            message: "current word remain input times",
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  homeCtrl.remainInputTimes.value.toString(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Tooltip(
                            message: "Number of remaining words",
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  homeCtrl.wordList.length.toString(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "You need to add words to the list first, click right top corner to add words",
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20)),
                  ),
                ),
              );
      }),
    );
  }
}
