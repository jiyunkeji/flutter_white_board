import 'package:flutter/services.dart';
import 'package:white_board/platform_interface.dart';

class WhiteBoardMethodChannel implements WhiteBoardPlatformController {
  final MethodChannel _channel;

  WhiteBoardMethodChannel(int id)
      : _channel = MethodChannel('com.jykj.white_board/textView_$id') {
    _channel.setMethodCallHandler(_onMethodCall);
  }

  Future<bool> _onMethodCall(MethodCall call) async {
    // switch (call.method) {
    //   case 'javascriptChannelMessage':
    //     final String channel = call.arguments['channel'];
    //     final String message = call.arguments['message'];
    //     _platformCallbacksHandler.onJavaScriptChannelMessage(channel, message);
    //     return true;

    // }

    return false;
  }

  @override
  Future<void> setStrokeColor(int r, int g, int b) {
    print('$r');
    print('$g');
    print('$b');
    return _channel.invokeMethod<void>('setStrokeColor', <String, dynamic>{
      'r': r,
      'g': g,
      'b': b,
    });
  }
}
