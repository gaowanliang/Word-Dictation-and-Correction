import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:word_dictation/data/common/constant.dart';
import 'package:word_dictation/screen/listening_word_select/generate_article_important.dart';

class ListeningWordSelectScreen extends StatelessWidget {
  ListeningWordSelectScreen({Key? key}) : super(key: key);
  final _editCtrl = TextEditingController();

  TextSpan _buildTextSpan(String text, int index, Color borderColor,
      Color textColor, Function feedback) {
    return TextSpan(
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          feedback();
        },
      text: text,
      style: TextStyle(
        background: Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
        color: textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var listeningArticle =
        """Lorem ipsum dolor sit amet, ea ornatus civibus conceptam has, eam case aeque tantas ei. Mea at causae tacimates. Ei sed oporteat lucilius interpretaris. Corpora detracto omnesque sit no, eam no dolor nullam. Adhuc expetendis eu nam. Te ius ferri feugait. An vix inani molestie dissentiunt, has assum iriure mentitum ei.

Aperiam euismod cu eam. Nihil gloriatur duo ad, eum in etiam malorum, graece scribentur sit ex. Ut sed discere omnesque. Inani facilis in vel, inermis quaerendum pri id, sea posse habemus singulis id.""";

    var isShowText = false.obs;
    var isUsuallyUsingWordsNeedVisible = false.obs;
    var words = <WordInfo>[].obs;

    generateInfo(bool showText) {
      words.clear();

      listeningArticle.splitMapJoin(
        RegExp('\\w+'),
        onMatch: (m) {
          final matchStr = m.group(0);
          // 标识这个单词是第几个
          words.add(WordInfo(matchStr!, true, false));
          return matchStr;
        },
        onNonMatch: (string) {
          words.add(WordInfo(string, false, false));

          return string;
        },
      );
    }

    // generateInfo(isShowText.value);

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(''),
          centerTitle: true,
          actions: words.isNotEmpty
              ? [
                  IconButton(
                      onPressed: () => words.clear(),
                      icon: const Icon(Icons.delete_outline_outlined)),
                  IconButton(
                      onPressed: () {
                        isShowText.value = !isShowText.value;
                        //generateInfo(isShowText.value);
                        words.refresh();
                      },
                      icon: Icon(isShowText.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined)),
                  IconButton(
                    onPressed: () => isUsuallyUsingWordsNeedVisible.value =
                        !isUsuallyUsingWordsNeedVisible.value,
                    icon: Icon(isUsuallyUsingWordsNeedVisible.value
                        ? Icons.key_outlined
                        : Icons.key_off_outlined),
                  ),
                  IconButton(
                      onPressed: () {
                        var articleText = "";
                        var importantWord = <String>[];
                        var adjecentSentence = <String>[];
                        var isNotDelete = true;
                        for (var i = 0; i < words.length; i++) {
                          if (words[i].isWord && words[i].isSelect) {
                            articleText += "**${words[i].word}**";
                            if (i > 0 &&
                                words[i - 1].word == " " &&
                                words[i - 2].isSelect) {
                              if (adjecentSentence.length > 1) {
                                adjecentSentence
                                    .removeAt(adjecentSentence.length - 1);
                              }
                              adjecentSentence.add(words[i - 2].word);
                              adjecentSentence.add(words[i].word);
                              if (isNotDelete) {
                                isNotDelete = false;
                                importantWord
                                    .removeAt(importantWord.length - 1);
                              }

                              continue;
                            } else {
                              if (adjecentSentence.isNotEmpty) {
                                importantWord
                                    .add("1. ${adjecentSentence.join(" ")}\n");
                                adjecentSentence = [];
                                isNotDelete = true;
                              }
                            }
                            importantWord.add("1. ${words[i].word}\n");
                          } else {
                            articleText += words[i].word;
                          }
                        }
                        if (adjecentSentence.isNotEmpty) {
                          importantWord
                              .add("1. ${adjecentSentence.join(" ")}\n");
                          adjecentSentence = [];
                          isNotDelete = true;
                        }
                        Get.to(() => GenerateArticleImportant(
                              articleText: articleText,
                              importantWord: importantWord.join(""),
                            ));
                      },
                      icon: const Icon(Icons.generating_tokens_outlined)),
                ]
              : null,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: words.isEmpty
              ? Column(
                  children: [
                    if (_editCtrl.text.isEmpty) const Text(""),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _editCtrl,
                      maxLines: 10,
                      minLines: 10,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Listening Article",
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () {
                          listeningArticle = _editCtrl.text;
                          listeningArticle =
                              listeningArticle.replaceAll("\n", "\n\n");
                          generateInfo(isShowText.value);
                        },
                        child: const Text("Generate"))
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: List.generate(
                            words.length,
                            (index) {
                              var borderColor = Colors.transparent;
                              if (words[index].isWord) {
                                if (isShowText.value) {
                                  // 在显示文章内容的模式下，只有选中的单词才会有边框
                                  if (words[index].isSelect) {
                                    borderColor = Colors.red;
                                  } else {
                                    borderColor = Colors.transparent;
                                  }
                                } else {
                                  // 在不显示文章内容的情况下，所有的单词都有蓝色边框，只有选中单词的边框是红色的

                                  if (words[index].isSelect) {
                                    borderColor = Colors.red;
                                  } else {
                                    borderColor = Colors.blue;
                                  }
                                }
                              }

                              var textColor =
                                  Theme.of(context).textTheme.bodyLarge!.color!;
                              if (!isShowText.value) {
                                if (isUsuallyUsingWordsNeedVisible.value) {
                                  if (!englishUsuallyUsingWords
                                      .contains(words[index].word)) {
                                    if (words[index].isWord) {
                                      textColor = Colors.transparent;
                                    }
                                  }
                                } else {
                                  if (words[index].isWord) {
                                    textColor = Colors.transparent;
                                  }
                                }
                              }

                              return _buildTextSpan(words[index].word, index,
                                  borderColor, textColor, () {
                                words[index].isSelect = !words[index].isSelect;
                                words.refresh();
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class WordInfo {
  String word;
  bool isWord;
  bool isSelect;

  WordInfo(this.word, this.isWord, this.isSelect);
}
