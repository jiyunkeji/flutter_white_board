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
@interface FLTWhiteBoardViewController()
@property(nonatomic,strong)FLTWhiteBoardManager *manager;
@end

@implementation FLTWhiteBoardViewController{
  FLTWhiteBoardView* _whiteBoardView;
  int64_t _viewId;
  FlutterMethodChannel* _channel;
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
    _viewId = viewId;

    NSString* channelName = [NSString stringWithFormat:@"com.jykj.white_board/textView_%lld", viewId];
    _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];

   

    _whiteBoardView = [[FLTWhiteBoardView alloc] initWithFrame:frame];
      

    self.manager = [[FLTWhiteBoardManager alloc]initWithWhiteBoardView:_whiteBoardView];
      [self.manager initSDK];
      [self.manager joinRoomWithToken];
      
    __weak __typeof__(self) weakSelf = self;
    [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
      [weakSelf onMethodCall:call result:result];
    }];

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
@end
