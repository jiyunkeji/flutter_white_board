//
//  FLTWhiteBoardViewFactory.h
//  dsBridge
//
//  Created by yrx on 2020/9/14.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
NS_ASSUME_NONNULL_BEGIN

@interface FLTWhiteBoardViewFactory :  NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

@end

NS_ASSUME_NONNULL_END
