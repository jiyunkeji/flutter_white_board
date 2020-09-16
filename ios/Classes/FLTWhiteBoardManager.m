//
//  FLTWhiteBoardManager.m
//  dsBridge
//
//  Created by yrx on 2020/9/14.
//

#import "FLTWhiteBoardManager.h"
#import "WhiteRoomConfig.h"
#import "Whiteboard.h"
@interface FLTWhiteBoardManager()<WhiteCommonCallbackDelegate,WhiteRoomCallbackDelegate>
    
@property (nonatomic, strong) WhiteBoardView *boardView;
@property (nonatomic, strong) WhiteSDK *sdk;
@property (nonatomic, strong, nullable) WhiteRoom *room;

@end

@implementation FLTWhiteBoardManager

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView{
   self = [super init];
    if (self) {
        self.boardView = boardView;
    }
    return self;
}

- (void)initSDKWithAppId:(NSString *)appId
{
    // 4. 初始化 SDK 配置类，根据需求设置配置
    WhiteSdkConfiguration *config = [[WhiteSdkConfiguration alloc] initWithApp:appId];

    // 5. 初始化 WhiteSDK，并传入callback，可以在 Example 中查看 callback 实现
    self.sdk = [[WhiteSDK alloc] initWithWhiteBoardView:self.boardView config:config commonCallbackDelegate:self];
}

- (void)joinRoomWithToken:(NSString *)roomId tokenId:(NSString *)tokenId
{

    WhiteRoomConfig *roomConfig = [[WhiteRoomConfig alloc] initWithUuid:roomId roomToken:tokenId];
    
    [self.sdk joinRoomWithConfig:roomConfig callbacks:self completionHandler:^(BOOL success, WhiteRoom * _Nonnull room, NSError * _Nonnull error) {
        if (success) {
            self.room = room;
            if (self.delegate&&[self.delegate respondsToSelector:@selector(joinRoomSuccessWithRoomId:)]) {
                [self.delegate joinRoomSuccessWithRoomId:room.uuid];
            }
        } else {
            // 错误处理
        }
    }];
}
-(void)setStrokeColor:(FLTStrokeColor *)color{
    
    if (!self.room){
             return;
         }
    int r = color.r;
    int g = color.g;
    int b = color.b;
    NSLog(@"r:%d,g:%d,b:%d",r,g,b);
         WhiteMemberState *memberState = [[WhiteMemberState alloc]init];
    memberState.strokeColor= @[[NSNumber numberWithInt:r], [NSNumber numberWithInt:g], [NSNumber numberWithInt:b]];
    [self.room setMemberState:memberState];
}

#pragma WhiteRoomCallbackDelegate
-(void)fireRoomStateChanged:(WhiteRoomState *)modifyState{
    NSLog(@"%@",modifyState);
}
@end
