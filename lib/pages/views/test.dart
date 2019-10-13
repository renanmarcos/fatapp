import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  final String pageText;
  Test(this.pageText);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Test Page'),
      ),
    );
  }
}


