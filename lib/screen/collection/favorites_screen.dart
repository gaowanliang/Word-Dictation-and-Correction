import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final _editCtrl = TextEditingController();
  FavoritesScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    _editCtrl.text = text;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (_editCtrl.text.isEmpty)
              const Text(
                  "You don't have any favorite words yet. In Correction or Dictation, enter \"...\" in the input box to save the current word. Suppose you need to mark the saved words with a special marker, enter \"...\" followed by a number, for example \"...1\", without spaces or anything else in between, so you can add a special marker \"①\" to your word to help you tell if it is not spelled correctly because of its special pronunciation or if you think the word needs to be memorized better. You can set different markers for different types (you can write down the meaning of each marker and then use the same marker for the same type each time), the range of markers is 1~9."),
            const SizedBox(height: 10),
            TextField(
              controller: _editCtrl,
              maxLines: 10,
              minLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Favorites Words and Meanings",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
