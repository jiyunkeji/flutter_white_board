import 'dart:async';

import 'package:flutter/cupertino.dart';

abstract class WhiteBoardViewPlatform {
  Widget build(
      {BuildContext context,
      WhiteBoardViewPlatformCreatedCallback onWhiteBoardViewPlatformCreated,
      WhiteBoardPlatformCallbacksHandler callbacksHandler});
}

typedef WhiteBoardViewPlatformCreatedCallback = void Function(
    WhiteBoardPlatformController webViewPlatformController);

abstract class WhiteBoardPlatformController {
  Future<void> setStrokeColor(
    int r,
    int g,
    int b,
  ) {
    throw UnimplementedError(
        "WhiteBoard setTitle is not implemented on the current platform");
  }

  Future<void> init(
    String appId,
  ) {
    throw UnimplementedError(
        "WhiteBoard init is not implemented on the current platform");
  }

  Future<void> joinRoom(
    String roomId,
    String roomToken,
  ) {
    throw UnimplementedError(
        "WhiteBoard joinRoom is not implemented on the current platform");
  }
}

abstract class WhiteBoardPlatformCallbacksHandler {
  void onJoinRoomSuccess(String roomId);
}
