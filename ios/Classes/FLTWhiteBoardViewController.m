//
//  FLTWhiteBoardViewController.m
//  dsBridge
//
//  Created by yrx on 2020/9/14.
//

#import "FLTWhiteBoardViewController.h"
#import "FLTWhiteBoardManager.h"
#import "FLTWhiteBoardView.h"
#import "FLTStrokeColor.h"
@interface FLTWhiteBoardViewController()<FlutterStreamHandler,FLTWhiteBoardManagerDelegate>
@property(nonatomic,strong)FLTWhiteBoardManager *manager;
@end

@implementation FLTWhiteBoardViewController{
  FLTWhiteBoardView* _whiteBoardView;
  int64_t _viewId;
  FlutterMethodChannel* _channel;
  FlutterEventChannel* _eventChannel;
    FlutterEventSink _eventSink;
    
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
    _viewId = viewId;
      NSLog(@"FLTWhiteBoardViewController  %lld",viewId);
    NSString* channelName = [NSString stringWithFormat:@"com.jykj.white_board/textView_%lld", viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
    _eventChannel = [FlutterEventChannel eventChannelWithName:[NSString stringWithFormat:@"com.jykj.white_board/textView_event_%lld",viewId] binaryMessenger:messenger];
      
   

    _whiteBoardView = [[FLTWhiteBoardView alloc] initWithFrame:frame];
      

    self.manager = [[FLTWhiteBoardManager alloc]initWithWhiteBoardView:_whiteBoardView];
      self.manager.delegate = self;
      // [self.manager initSDKWithAppId:@"ehuvwNLlEeqTIve5DWs2Gg/KheA3hZvWA8XEA"];
      // [self.manager joinRoomWithToken:@"f31ed380d6e511ea9be4d9045066d16e" tokenId:@"WHITEcGFydG5lcl9pZD00NXRONWl5TWRWaDhYTjN1JnNpZz1jNGEwODEyOGE3MTYzOTQ2MGFkMWEwMmRkODY3ZTE5M2NhZjY5MGUwOmFrPTQ1dE41aXlNZFZoOFhOM3UmY3JlYXRlX3RpbWU9MTU5NjYwOTM3MDUzMSZleHBpcmVfdGltZT0xNjI4MTQ1MzcwNTMxJm5vbmNlPTE1OTY2MDkzNzA1MzEwMCZyb2xlPXJvb20mcm9vbUlkPWYzMWVkMzgwZDZlNTExZWE5YmU0ZDkwNDUwNjZkMTZlJnRlYW1JZD1laHV2d05MbEVlcVRJdmU1RFdzMkdn"];
 
    __weak __typeof__(self) weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      NSLog(@"iOS FlutterMethodCall");
      [weakSelf onMethodCall:call result:result];
    }];
      
       [_eventChannel setStreamHandler:self];


    if (@available(iOS 11.0, *)) {
      _whiteBoardView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
      if (@available(iOS 13.0, *)) {
        _whiteBoardView.scrollView.automaticallyAdjustsScrollIndicatorInsets = NO;
      }
    }
  }
  return self;
}

- (UIView*)view {
  return _whiteBoardView;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([[call method] isEqualToString:@"setStrokeColor"]) {
    [self setStrokeColor:call result:result];
  } else if ([[call method] isEqualToString:@"init"]){
      
       [self init:call result:result];
  }else if ([[call method] isEqualToString:@"joinRoom"]){
       [self joinRoom:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)setStrokeColor:(FlutterMethodCall*)call result:(FlutterResult)result {
    
   NSDictionary<NSString*, id>* request = [call arguments];
    int r = [request[@"r"] intValue];
      int g = [request[@"g"] intValue];
      int b = [request[@"b"] intValue];
 
    FLTStrokeColor *color = [[FLTStrokeColor alloc] init];
    color.r = r;
    color.g= g;
    color.b = b;
    [_manager setStrokeColor:color];
    
  result(@"setStrokeColor success");
}

- (void)init:(FlutterMethodCall*)call result:(FlutterResult)result {
    
   NSDictionary<NSString*, id>* request = [call arguments];
    NSString *appId = request[@"appId"];
  
    [_manager initSDKWithAppId:appId];
    
  result(@"init success");
}

- (void)joinRoom:(FlutterMethodCall*)call result:(FlutterResult)result {
    
     NSDictionary<NSString*, id>* request = [call arguments];
     NSString *roomId = request[@"roomId"];
    NSString *tokenId = request[@"roomToken"];
   
     [_manager joinRoomWithToken:roomId tokenId:tokenId];
    
  result(@"joinRoom success");
}

#pragma FLTWhiteBoardManagerDelegate
-(void)joinRoomSuccessWithRoomId:(NSString *)roomId{
    
    if(_eventSink){
        _eventSink(@{
           @"eventType" : @"joinRoomSuccess",
           @"roomId" : roomId,
         });
    }
  
}

#pragma  FlutterStreamHandler

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events{
    _eventSink = events;
    return nil;
}
-(FlutterError *)onCancelWithArguments:(id)arguments{
      _eventSink = nil;
    return nil;
}
@end
