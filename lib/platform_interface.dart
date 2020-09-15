import 'package:flutter/cupertino.dart';

abstract class WhiteBoardViewPlatform {
  Widget build(
      {BuildContext context,
      WhiteBoardViewPlatformCreatedCallback onWhiteBoardViewPlatformCreated});
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
}
