// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:white_board/platform_interface.dart';
import 'package:white_board/src/white_board_method_channel.dart';

/// Builds an Android webview.
///
/// This is used as the default implementation for [WebView.platform] on Android. It uses
/// an [AndroidView] to embed the webview in the widget hierarchy, and uses a method channel to
/// communicate with the platform code.
class AndroidWhiteBoardView implements WhiteBoardViewPlatform {
  @override
  Widget build({
    BuildContext context,
    WhiteBoardViewPlatformCreatedCallback onWhiteBoardViewPlatformCreated,
  }) {
    return GestureDetector(
      onLongPress: () {},
      excludeFromSemantics: true,
      child: AndroidView(
        viewType: 'com.jykj.white_board/textView',
        onPlatformViewCreated: (int id) {
          if (onWhiteBoardViewPlatformCreated == null) {
            return;
          }
          onWhiteBoardViewPlatformCreated(WhiteBoardMethodChannel(id));
        },
      ),
    );
  }
}
