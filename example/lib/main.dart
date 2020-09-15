import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:white_board/white_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WhiteBoardViewController whiteBoardViewController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
          Container(
            width: 400,
            height: 300,
            child: WhiteBoard(
              onWhiteBoardViewCreated:
                  (WhiteBoardViewController whiteBoardViewController) {
                this.whiteBoardViewController = whiteBoardViewController;
              },
            ),
          ),
          GestureDetector(
            onTap: () async {
              await whiteBoardViewController.setStrokeColor(0, 0, 255);
            },
            child: Container(
              width: 100,
              height: 60,
              padding: EdgeInsets.all(10),
              color: Colors.red,
              child: Center(
                child: Text(
                  "更改颜色",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
