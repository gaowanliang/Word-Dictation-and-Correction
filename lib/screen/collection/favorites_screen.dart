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
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (_editCtrl.text.isEmpty)
              Text(
                  "You don't have any favorite words yet. In Correction or Dictation, enter \"...\" in the input box to save the current word"),
            SizedBox(height: 10),
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
