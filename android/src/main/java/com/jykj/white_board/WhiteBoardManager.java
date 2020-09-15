package com.jykj.white_board;

import android.content.Context;
import android.util.Log;

import com.herewhite.sdk.AbstractRoomCallbacks;
import com.herewhite.sdk.CommonCallbacks;
import com.herewhite.sdk.Room;
import com.herewhite.sdk.RoomParams;
import com.herewhite.sdk.WhiteSdk;
import com.herewhite.sdk.WhiteSdkConfiguration;
import com.herewhite.sdk.WhiteboardView;
import com.herewhite.sdk.domain.MemberState;
import com.herewhite.sdk.domain.Promise;
import com.herewhite.sdk.domain.RoomPhase;
import com.herewhite.sdk.domain.RoomState;
import com.herewhite.sdk.domain.SDKError;
import com.herewhite.sdk.domain.UrlInterrupter;

public class WhiteBoardManager {
    private static WhiteBoardManager _instance;
    private WhiteboardView boardView;

    private Context context;

    private WhiteSdk whiteSdk;
    private Room room;
    private StrokeColor strokeColor;

    public StrokeColor getStrokeColor() {
        return strokeColor;
    }

    public void setStrokeColor(StrokeColor strokeColor) {
        this.strokeColor = strokeColor;
        setRoomStrokeColor(strokeColor);
    }

    public WhiteboardView getBoardView() {
        return boardView;
    }

    public void setBoardView(WhiteboardView boardView) {
        this.boardView = boardView;
    }

    public static WhiteBoardManager getInstance() {

        if (_instance == null) {
            synchronized (WhiteBoardManager.class) {
                if (_instance == null) {
                    _instance = new WhiteBoardManager();
                }
            }
        }
        return _instance;
    }

    private WhiteBoardManager() {
    }

    public void init(Context context, InitOptions options) {
//          whiteBroadView.addView(whiteboardView);
        Log.e("2","boardView"+getBoardView());
        this.context = context;
        String appId = options.getAppId();//ehuvwNLlEeqTIve5DWs2Gg/KheA3hZvWA8XEA

        WhiteSdkConfiguration sdkConfiguration = new WhiteSdkConfiguration(appId, true);

        /*显示用户头像*/
        sdkConfiguration.setUserCursor(true);

        //动态 ppt 需要的自定义字体，如果没有使用，无需调用
//          HashMap<String, String> map = new HashMap<>();
//          map.put("宋体","https://your-cdn.com/Songti.ttf");
//          sdkConfiguration.setFonts(map);

        //图片替换 API，需要在 whiteSDKConfig 中先行调用 setHasUrlInterrupterAPI，进行设置，否则不会被回调。
        whiteSdk = new WhiteSdk(getBoardView(), context, sdkConfiguration,
                new UrlInterrupter() {
                    @Override
                    public String urlInterrupter(String sourceUrl) {
                        return sourceUrl;
                    }
                });

        /** 设置自定义全局状态，在后续回调中 GlobalState 直接进行类型转换即可 */
//          WhiteDisplayerState.setCustomGlobalStateClass(this.context);

        whiteSdk.setCommonCallbacks(new CommonCallbacks() {
            @Override
            public String urlInterrupter(String sourceUrl) {
                return sourceUrl;
            }

            @Override
            public void sdkSetupFail(SDKError error) {
                Log.e("ROOM_ERROR", error.toString());
            }

            @Override
            public void throwError(Object args) {

            }

            @Override
            public void onPPTMediaPlay() {

            }

            @Override
            public void onPPTMediaPause() {
            }
        });


    }

    public  void joinRoom(JoinRoomOptions options){
        //如需支持用户头像，请在设置 WhiteSdkConfiguration 后，再调用 setUserPayload 方法，传入符合用户信息
        String roomId = options.getRoomId();
        String roomToken = options.getRoomToken();
        RoomParams roomParams = new RoomParams(roomId, roomToken);
        Log.e("2","joinRoom");
        whiteSdk.joinRoom(roomParams, new AbstractRoomCallbacks() {
            @Override
            public void onPhaseChanged(RoomPhase phase) {
                //在此处可以处理断连后的重连逻辑
//                  showToast(phase.name());
                Log.e("2",phase.name());

            }

            @Override
            public void onRoomStateChanged(RoomState modifyState) {
                Log.e("2",modifyState.toJSON().toString());


            }
        }, new Promise<Room>() {
            @Override
            public void then(Room wRoom) {
                room = wRoom;
                if (getStrokeColor()!=null){
                    setRoomStrokeColor(getStrokeColor());
                }
            }

            @Override
            public void catchEx(SDKError t) {
                Log.e("2", t.getMessage());
            }
        });
    }

    public  void  setRoomStrokeColor(StrokeColor rgb){
        if (room==null){
            return;
        }
        int r = rgb.getR();//ehuvwNLlEeqTIve5DWs2Gg/KheA3hZvWA8XEA
        int g = rgb.getG();
        int b = rgb.getB();
        Log.e("2",r +",,,,"+g+",,,,"+b);
        MemberState memberState = new MemberState();
        memberState.setStrokeColor(new int[]{r, g, b});
        room.setMemberState(memberState);
    }
}

class  StrokeColor{
    private  int r;
    private  int g;
    private  int b;

    public int getR() {
        return r;
    }

    public void setR(int r) {
        this.r = r;
    }

    public int getG() {
        return g;
    }

    public void setG(int g) {
        this.g = g;
    }

    public int getB() {
        return b;
    }

    public void setB(int b) {
        this.b = b;
    }
}
class  InitOptions{
    private  String appId;

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }
}
class  JoinRoomOptions{
    private  String roomId;
    private  String roomToken;

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getRoomToken() {
        return roomToken;
    }

    public void setRoomToken(String roomToken) {
        this.roomToken = roomToken;
    }
}
