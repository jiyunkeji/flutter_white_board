package com.jykj.white_board;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.herewhite.sdk.WhiteboardView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.platform.PlatformView;

public class WhiteBoardView implements PlatformView, MethodChannel.MethodCallHandler, Callback, EventChannel.StreamHandler {
    WhiteboardView wb;
    private final MethodChannel methodChannel;
    private final EventChannel eventChannel;
    private EventChannel.EventSink eventSink;
    private WhiteBoardManager wbManager;
    private Context context;


    public WhiteBoardView(final Context context,
                          BinaryMessenger messenger,
                          int id,
                          Map<String, Object> params,
                          View containerView) {
        this.context = context;
        wb = new WhiteboardView(context);
        methodChannel = new MethodChannel(messenger, "com.jykj.white_board/textView_" + id);
        methodChannel.setMethodCallHandler(this);

        eventChannel = new EventChannel(messenger, "com.jykj.white_board/textView_event_" + id);
        eventChannel.setStreamHandler(this);

        wbManager = WhiteBoardManager.getInstance();
        wbManager.setCallback(this);
        wbManager.setBoardView(wb);
        wbManager.setMethodChannel(methodChannel);

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

        switch (call.method) {
            case "setStrokeColor":

                setStrokeColor(call, result);
                break;
            case "init":

                init(call, result);
                break;
            case "joinRoom":

                joinRoom(call, result);
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

    private void init(MethodCall methodCall, MethodChannel.Result result) {
        Map<String, Object> request = (Map<String, Object>) methodCall.arguments;
        String appId = (String) request.get("appId");

        InitOptions options = new InitOptions();
        options.setAppId(appId);
        wbManager.init(context, options);

        result.success(null);
    }

    private void joinRoom(MethodCall methodCall, MethodChannel.Result result) {
        Map<String, Object> request = (Map<String, Object>) methodCall.arguments;

        String roomId = (String) request.get("roomId");
        String roomToken = (String) request.get("roomToken");
        JoinRoomOptions joinRoomOptions = new JoinRoomOptions();
        joinRoomOptions.setRoomId(roomId);
        joinRoomOptions.setRoomToken(roomToken);
        wbManager.joinRoom(joinRoomOptions, result);
        // result.success("");
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

    @Override
    public void onJoinRoomSuccess(String roomId) {

        //方法1
        wbManager.onJoinRoomSuccess(roomId);

        //方法2
        if (eventSink != null) {
            Map<String, Object> event = new HashMap<>();
            event.put("eventType", "joinRoomSuccess");
            event.put("roomId", roomId);
            eventSink.success(event);
        }

    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {

        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }
}