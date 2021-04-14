import 'package:flutter/material.dart';

class TextExamplePage extends StatefulWidget {
  @override
  _TextExamplePageState createState() => _TextExamplePageState();
}

class _TextExamplePageState extends State<TextExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('ASDASD'),
          ],
        ),
      ),
    );
  }
}
