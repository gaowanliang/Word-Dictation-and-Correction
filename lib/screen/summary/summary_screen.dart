import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final _editCtrl = TextEditingController();
  SummaryScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    _editCtrl.text = text;
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _editCtrl,
            maxLines: 10,
            minLines: 10,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Wrong words",
            ),
          ),
        ),
      ),
    );
  }
}
