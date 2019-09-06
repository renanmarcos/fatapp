import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  final String pageText;
  Teste(this.pageText);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Test Page'),
      )
    );
  }
}