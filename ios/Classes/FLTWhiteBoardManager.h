//
//  FLTWhiteBoardManager.h
//  dsBridge
//
//  Created by yrx on 2020/9/14.
//

#import <Foundation/Foundation.h>
#import "WhiteSDK.h"
#import "FLTStrokeColor.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLTWhiteBoardManager : NSObject

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView;
-(void)setStrokeColor:(FLTStrokeColor *)color;
- (void)initSDK;
- (void)joinRoomWithToken;
@end

NS_ASSUME_NONNULL_END
