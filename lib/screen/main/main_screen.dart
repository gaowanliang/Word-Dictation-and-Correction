import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:word_dictation/modules/controller.dart';
import 'package:word_dictation/screen/setting/setting_screen.dart';
import 'package:word_dictation/screen/summary/summary_screen.dart';
import 'package:word_dictation/utils/extensions.dart';

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

  Future _speak(String text) async {
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future<dynamic> _getLanguages() async {
    var test = await flutterTts.getLanguages;
    print(test);
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
        return;
      }
      homeCtrl.remainInputTimes.value--;
      _wordInputController.clear();
      FocusScope.of(context).requestFocus(focusNode);

      _speak(homeCtrl.wordList[0]);
    } else {
      SmartDialog.showToast('Wrong answer, please try again');
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
        title: const Text('Word auditory memory'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _launchUrl();
          },
          icon: SvgPicture.asset(
            "image/github.svg",
            colorFilter: ColorFilter.mode(
                Theme.of(context).textTheme.bodyLarge!.color!, BlendMode.srcIn),
          ),
        ),
        actions: [
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
        if (homeCtrl.wordList.isNotEmpty) {
          _speak(homeCtrl.wordList[0]);
        }
        return homeCtrl.wordList.isNotEmpty
            ? Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          MediaQuery.of(context).size.height *
                              (keyboardVisible ? 0.15 : 0.25),
                          0,
                          0),
                      child: homeCtrl.mode.value == 1
                          ? Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      homeCtrl.remainInputTimes.value
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
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
                                                fontSize: MediaQuery.of(context)
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
                                ),
                                Text(
                                  homeCtrl.wordMeaningList[0],
                                  style: GoogleFonts.notoSans(
                                      textStyle: TextStyle(fontSize: 25)),
                                ),
                              ],
                            )
                          : IconButton(
                              onPressed: () {
                                _speak(homeCtrl.wordList[0]);
                              },
                              icon: const Icon(Icons.record_voice_over)),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        0,
                        0,
                        MediaQuery.of(context).size.width >
                                MediaQuery.of(context).size.height
                            ? MediaQuery.of(context).size.height * 0.1
                            : MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: Form(
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
                                      textStyle: TextStyle(fontSize: 20)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
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
