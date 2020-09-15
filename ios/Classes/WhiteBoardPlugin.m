#import "WhiteBoardPlugin.h"
#import "FLTWhiteBoardViewFactory.h"

@implementation WhiteBoardPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FLTWhiteBoardViewFactory* whiteBoardViewFactory =
      [[FLTWhiteBoardViewFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:whiteBoardViewFactory withId:@"com.jykj.white_board/textView"];
}

@end
