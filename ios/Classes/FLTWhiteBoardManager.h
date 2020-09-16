//
//  FLTWhiteBoardManager.h
//  dsBridge
//
//  Created by yrx on 2020/9/14.
//

#import <Foundation/Foundation.h>
#import "WhiteSDK.h"
#import "FLTStrokeColor.h"
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FLTWhiteBoardManagerDelegate <NSObject>

-(void)joinRoomSuccessWithRoomId:(NSString *)roomId;

@end

@interface FLTWhiteBoardManager : NSObject

@property(weak,nonatomic)id<FLTWhiteBoardManagerDelegate> delegate;

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView;
-(void)setStrokeColor:(FLTStrokeColor *)color;
- (void)initSDKWithAppId:(NSString *)appId;
- (void)joinRoomWithToken:(NSString *)roomId tokenId:(NSString *)tokenId;
-(void)joinSuccess:(FlutterMethodChannel *)methodChannel roomId:(NSString *)roomId;
@end

NS_ASSUME_NONNULL_END
