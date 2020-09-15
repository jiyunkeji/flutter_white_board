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

- (void)initSDK
{
    // 4. 初始化 SDK 配置类，根据需求设置配置
    WhiteSdkConfiguration *config = [[WhiteSdkConfiguration alloc] initWithApp:@"ehuvwNLlEeqTIve5DWs2Gg/KheA3hZvWA8XEA"];

    // 5. 初始化 WhiteSDK，并传入callback，可以在 Example 中查看 callback 实现
    self.sdk = [[WhiteSDK alloc] initWithWhiteBoardView:self.boardView config:config commonCallbackDelegate:self];
}

- (void)joinRoomWithToken
{

    WhiteRoomConfig *roomConfig = [[WhiteRoomConfig alloc] initWithUuid:@"f31ed380d6e511ea9be4d9045066d16e" roomToken:@"WHITEcGFydG5lcl9pZD00NXRONWl5TWRWaDhYTjN1JnNpZz1jNGEwODEyOGE3MTYzOTQ2MGFkMWEwMmRkODY3ZTE5M2NhZjY5MGUwOmFrPTQ1dE41aXlNZFZoOFhOM3UmY3JlYXRlX3RpbWU9MTU5NjYwOTM3MDUzMSZleHBpcmVfdGltZT0xNjI4MTQ1MzcwNTMxJm5vbmNlPTE1OTY2MDkzNzA1MzEwMCZyb2xlPXJvb20mcm9vbUlkPWYzMWVkMzgwZDZlNTExZWE5YmU0ZDkwNDUwNjZkMTZlJnRlYW1JZD1laHV2d05MbEVlcVRJdmU1RFdzMkdn"];
    
    [self.sdk joinRoomWithConfig:roomConfig callbacks:self completionHandler:^(BOOL success, WhiteRoom * _Nonnull room, NSError * _Nonnull error) {
        if (success) {
            self.room = room;
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
    NSLog(@"fireRoomStateChanged");
//    NSLog([[NSString stringWithFormat:@"%s",[modifyState memberState]] strokeColor]);
}
@end
