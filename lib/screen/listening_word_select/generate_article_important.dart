import 'package:flutter/material.dart';

class GenerateArticleImportant extends StatelessWidget {
  GenerateArticleImportant({
    Key? key,
    required this.articleText,
    required this.importantWord,
  }) : super(key: key);
  final _editCtrl = TextEditingController();
  final _editCtrl2 = TextEditingController();
  final String articleText;
  final String importantWord;

  @override
  Widget build(BuildContext context) {
    _editCtrl.text = articleText;
    _editCtrl2.text = importantWord;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _editCtrl,
                maxLines: 10,
                minLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Article",
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _editCtrl2,
                maxLines: 10,
                minLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Important Word",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
