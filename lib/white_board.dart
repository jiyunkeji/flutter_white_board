import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:white_board/platform_interface.dart';
import 'package:white_board/src/white_board_android.dart';
import 'package:white_board/src/white_board_ios.dart';

typedef void WhiteBoardViewCreatedCallback(WhiteBoardViewController controller);
typedef void JoinRoomSuccessCallBack(String roomId);

class WhiteBoard extends StatefulWidget {
  const WhiteBoard({this.onWhiteBoardViewCreated, this.onJoinRoomSuccess});

  final WhiteBoardViewCreatedCallback onWhiteBoardViewCreated;
  final JoinRoomSuccessCallBack onJoinRoomSuccess;

  static WhiteBoardViewPlatform _platform;

  static set platform(WhiteBoardViewPlatform platform) {
    _platform = platform;
  }

  static WhiteBoardViewPlatform get platform {
    if (_platform == null) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          _platform = AndroidWhiteBoardView();
          break;
        case TargetPlatform.iOS:
          _platform = IosWhiteBoardView();
          break;
        default:
          throw UnsupportedError(
              "Trying to use the default webview implementation for $defaultTargetPlatform but there isn't a default one");
      }
    }
    return _platform;
  }

  @override
  State<StatefulWidget> createState() {
    return _WhiteBoardState();
  }
}

class _WhiteBoardState extends State<WhiteBoard> {
  _PlatformCallbacksHandler _platformCallbacksHandler;
  @override
  Widget build(BuildContext context) {
    return WhiteBoard.platform.build(
        context: context,
        onWhiteBoardViewPlatformCreated: _onWhiteBoardViewPlatformCreated,
        callbacksHandler: _platformCallbacksHandler);
  }

  void _onWhiteBoardViewPlatformCreated(
      WhiteBoardPlatformController whiteBoardViewPlatform) {
    final WhiteBoardViewController controller =
        WhiteBoardViewController._(whiteBoardViewPlatform);
    if (widget.onWhiteBoardViewCreated != null) {
      widget.onWhiteBoardViewCreated(controller);
    }
  }

  @override
  void initState() {
    super.initState();
    _platformCallbacksHandler = _PlatformCallbacksHandler(widget);
  }
}

class WhiteBoardViewController {
  WhiteBoardViewController._(
    this._whiteBoardViewPlatformController,
  ) : assert(_whiteBoardViewPlatformController != null);

  final WhiteBoardPlatformController _whiteBoardViewPlatformController;

  Future<void> setStrokeColor(
    int r,
    int g,
    int b,
  ) async {
    return await _whiteBoardViewPlatformController.setStrokeColor(r, g, b);
  }

  Future<void> init(
    String appId,
  ) async {
    return await _whiteBoardViewPlatformController.init(appId);
  }

  Future<void> joinRoom(
    String roomId,
    String roomToken,
  ) async {
    return await _whiteBoardViewPlatformController.joinRoom(roomId, roomToken);
  }
}

class _PlatformCallbacksHandler implements WhiteBoardPlatformCallbacksHandler {
  _PlatformCallbacksHandler(this._widget);
  WhiteBoard _widget;
  @override
  void onJoinRoomSuccess(String roomId) {
    _widget.onJoinRoomSuccess(roomId);
  }
}
