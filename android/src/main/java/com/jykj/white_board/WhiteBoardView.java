package com.jykj.white_board;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.herewhite.sdk.WhiteboardView;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class WhiteBoardView implements PlatformView, MethodChannel.MethodCallHandler {
    WhiteboardView wb;
    private final MethodChannel methodChannel;
    private WhiteBoardManager wbManager;
    private Context context;


    public WhiteBoardView(final Context context,
                          BinaryMessenger messenger,
                          int id,
                          Map<String, Object> params,
                          View containerView) {
        this.context = context;
        wb = new WhiteboardView(context);

        InitOptions options = new InitOptions();
        options.setAppId("ehuvwNLlEeqTIve5DWs2Gg/KheA3hZvWA8XEA");
        wbManager = WhiteBoardManager.getInstance();
        wbManager.setBoardView(wb);
        wbManager.init(context, options);
        wbManager.setBoardView(wb);

        JoinRoomOptions joinRoomOptions = new JoinRoomOptions();
        joinRoomOptions.setRoomId("f31ed380d6e511ea9be4d9045066d16e");
        joinRoomOptions.setRoomToken("WHITEcGFydG5lcl9pZD00NXRONWl5TWRWaDhYTjN1JnNpZz1jNGEwODEyOGE3MTYzOTQ2MGFkMWEwMmRkODY3ZTE5M2NhZjY5MGUwOmFrPTQ1dE41aXlNZFZoOFhOM3UmY3JlYXRlX3RpbWU9MTU5NjYwOTM3MDUzMSZleHBpcmVfdGltZT0xNjI4MTQ1MzcwNTMxJm5vbmNlPTE1OTY2MDkzNzA1MzEwMCZyb2xlPXJvb20mcm9vbUlkPWYzMWVkMzgwZDZlNTExZWE5YmU0ZDkwNDUwNjZkMTZlJnRlYW1JZD1laHV2d05MbEVlcVRJdmU1RFdzMkdn");
        wbManager.joinRoom(joinRoomOptions);

        methodChannel = new MethodChannel(messenger, "com.jykj.white_board/textView_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

        switch (call.method) {
            case "setStrokeColor":

                setStrokeColor(call, result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void setStrokeColor(MethodCall methodCall, MethodChannel.Result result) {
        Map<String, Object> request = (Map<String, Object>) methodCall.arguments;
        int r = (int) request.get("r");
        int g = (int) request.get("g");
        int b = (int) request.get("b");

        StrokeColor color = new StrokeColor();
        color.setR(r);
        color.setB(b);
        color.setG(g);
        wbManager.setStrokeColor(color);
        result.success(null);
    }

    @Override
    public View getView() {
        return wb;
    }

    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {

    }

    @Override
    public void onFlutterViewDetached() {

    }

    @Override
    public void dispose() {

    }

    @Override
    public void onInputConnectionLocked() {

    }

    @Override
    public void onInputConnectionUnlocked() {

    }
}