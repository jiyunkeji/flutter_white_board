//
//  FLTWhiteBoardViewFactory.m
//  dsBridge
//
//  Created by yrx on 2020/9/14.
//

#import "FLTWhiteBoardViewFactory.h"
#import "FLTWhiteBoardViewController.h"

@implementation FLTWhiteBoardViewFactory{
  NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  FLTWhiteBoardViewController* whiteBoardViewController = [[FLTWhiteBoardViewController alloc] initWithFrame:frame
                                                                         viewIdentifier:viewId
                                                                              arguments:args
                                                                        binaryMessenger:_messenger];
  return whiteBoardViewController;
}

@end
