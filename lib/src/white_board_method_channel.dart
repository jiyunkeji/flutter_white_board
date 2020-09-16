import 'package:flutter/services.dart';
import 'package:white_board/platform_interface.dart';

class WhiteBoardMethodChannel implements WhiteBoardPlatformController {
  final MethodChannel _channel;
  EventChannel _eventchannel;
  final WhiteBoardPlatformCallbacksHandler _platformCallbacksHandler;

  WhiteBoardMethodChannel(int id, this._platformCallbacksHandler)
      : assert(_platformCallbacksHandler != null),
        _channel = MethodChannel('com.jykj.white_board/textView_$id') {
    _channel.setMethodCallHandler(_onMethodCall);

    _eventchannel = EventChannel('com.jykj.white_board/textView_event_$id');
    _eventchannel.receiveBroadcastStream().listen(_listener);
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

  void _listener(dynamic event) {
    final Map<dynamic, dynamic> map = event;
    switch (map['eventType']) {
      case 'joinRoomSuccess':
        String roomId = map['roomId'];
        _platformCallbacksHandler.onJoinRoomSuccess(roomId);
        break;
    }
  }

  @override
  Future<void> setStrokeColor(int r, int g, int b) async {
    return await _channel
        .invokeMethod<void>('setStrokeColor', <String, dynamic>{
      'r': r,
      'g': g,
      'b': b,
    });
  }

  @override
  Future<void> init(String appId) async {
    return await _channel.invokeMethod<void>('init', <String, dynamic>{
      'appId': appId,
    });
  }

  @override
  Future<void> joinRoom(String roomId, String roomToken) async {
    return await _channel.invokeMethod<void>('joinRoom', <String, dynamic>{
      'roomId': roomId,
      'roomToken': roomToken,
    });
  }
}
