import 'package:flutter/material.dart';
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

  onWhiteBoardViewCreate() async {
    print("before init");
    await whiteBoardViewController
        .init('ehuvwNLlEeqTIve5DWs2Gg/KheA3hZvWA8XEA');
    print("end init");
    print("before joinRoom");
    await whiteBoardViewController.joinRoom("f31ed380d6e511ea9be4d9045066d16e",
        "WHITEcGFydG5lcl9pZD00NXRONWl5TWRWaDhYTjN1JnNpZz1jNGEwODEyOGE3MTYzOTQ2MGFkMWEwMmRkODY3ZTE5M2NhZjY5MGUwOmFrPTQ1dE41aXlNZFZoOFhOM3UmY3JlYXRlX3RpbWU9MTU5NjYwOTM3MDUzMSZleHBpcmVfdGltZT0xNjI4MTQ1MzcwNTMxJm5vbmNlPTE1OTY2MDkzNzA1MzEwMCZyb2xlPXJvb20mcm9vbUlkPWYzMWVkMzgwZDZlNTExZWE5YmU0ZDkwNDUwNjZkMTZlJnRlYW1JZD1laHV2d05MbEVlcVRJdmU1RFdzMkdn");
    print("end joinRoom");
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
                onWhiteBoardViewCreate();
              },
              onJoinRoomSuccess: (roomId) {
                print("example roomId$roomId");
              },
            ),
          ),
          GestureDetector(
            onTap: () async {
              await whiteBoardViewController.setStrokeColor(1, 0, 0);
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
