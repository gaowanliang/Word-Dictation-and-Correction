import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:word_dictation/modules/controller.dart';
import 'package:word_dictation/screen/setting/tts_test.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController _textController = TextEditingController();
  TextEditingController _timesController = TextEditingController();
  final Rxn<int> selected = Rxn<int>();
  final homeCtrl = Get.find<HomeController>();
  final RxBool isBlur = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting'), centerTitle: true, actions: [
        IconButton(
          onPressed: () {
            Get.to(() => TTSTestScreen());
          },
          icon: const Icon(Icons.cruelty_free),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 一个多行文本框，用来设置用户需要背的单词
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textController,
                  maxLines: 10,
                  minLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Input words and meanings',
                  ),
                ),
              ),
              // 设置一个下拉列表，用来让用户选择分隔符
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Separator',
                  ),
                  value: homeCtrl.separator.value,
                  onChanged: (value) {
                    homeCtrl.separator.value = value.toString();
                  },
                  items: const [
                    DropdownMenuItem(
                      value: '\t',
                      child: Text('Tab'),
                    ),
                    DropdownMenuItem(
                      value: ' ',
                      child: Text('Space'),
                    ),
                    DropdownMenuItem(
                      value: ',',
                      child: Text('Comma'),
                    ),
                    DropdownMenuItem(
                      value: ';',
                      child: Text('Semicolon'),
                    ),
                  ],
                ),
              ),

              Obx(
                () => Column(
                  children: [
                    // 一个下拉列表，用来让用户选择TTS的语言
                    homeCtrl.ttsLanguages.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'TTS language',
                              ),
                              value: homeCtrl.ttsLanguages.contains("en-GB")
                                  ? "en-GB"
                                  : homeCtrl.ttsLanguages[0],
                              items: homeCtrl.ttsLanguages
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                homeCtrl.ttsLanguage.value = value.toString();
                              },
                            ),
                          )
                        : const Text(
                            'No TTS language found, maybe TTS engine blocked by system'),
                    // 两个checkbox，用来设置是改错模式还是听写模式，如果是改错模式，就显示一个文本框，用来规定一个单词改几遍，默认为改错模式

                    CheckboxListTile(
                      title: const Text('Correction mode'),
                      value: selected.value == 1,
                      onChanged: (value) {
                        if (value == true) {
                          selected.value = 1;
                        } else {
                          selected.value = 0;
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Dictation mode'),
                      value: selected.value == 2,
                      onChanged: (value) {
                        if (value == true) {
                          selected.value = 2;
                        } else {
                          selected.value = 0;
                        }
                      },
                    ),
                    if (selected.value == 1)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        // 文本框限制只能输入数字
                        child: TextField(
                          controller: _timesController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'How many times to correction',
                          ),
                        ),
                      ),
                    if (selected.value == 1)
                      CheckboxListTile(
                        title: const Text('Blur words until input error'),
                        value: isBlur.isTrue,
                        onChanged: (value) {
                          isBlur.value = value ?? false;
                        },
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_textController.text.isEmpty) {
                        SmartDialog.showToast(
                            'Please input words and meanings');
                        return;
                      } else if (selected.value == 1 &&
                          _timesController.text.isEmpty) {
                        SmartDialog.showToast('Please input times');
                        return;
                      } else if (selected.value == 1 &&
                          int.parse(_timesController.text) <= 0) {
                        SmartDialog.showToast('Times must be greater than 0');
                        return;
                      } else if (selected.value == 0) {
                        SmartDialog.showToast('Please select a mode');
                        return;
                      }
                      homeCtrl.saveWord(
                          _textController.text,
                          selected.value ?? 1,
                          int.parse(_timesController.text.isEmpty
                              ? '1'
                              : _timesController.text),
                          isBlur.value);

                      Get.back();
                    },
                    child: const Text('Save'),
                  ),
                ),
              ),
              // 版权信息以及GitHub地址
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Gaowan Liang © 2023- , Word Dictation, All rights reserved.',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.4)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
