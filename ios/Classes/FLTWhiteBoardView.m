//
//  FLTWhiteBoardView.m
//  dsBridge
//
//  Created by yrx on 2020/9/14.
//

#import "FLTWhiteBoardView.h"

@implementation FLTWhiteBoardView

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  self.scrollView.contentInset = UIEdgeInsetsZero;
  // We don't want the contentInsets to be adjusted by iOS, flutter should always take control of
  // webview's contentInsets.
  // self.scrollView.contentInset = UIEdgeInsetsZero;
  if (@available(iOS 11, *)) {
    // Above iOS 11, adjust contentInset to compensate the adjustedContentInset so the sum will
    // always be 0.
    if (UIEdgeInsetsEqualToEdgeInsets(self.scrollView.adjustedContentInset, UIEdgeInsetsZero)) {
      return;
    }
    UIEdgeInsets insetToAdjust = self.scrollView.adjustedContentInset;
    self.scrollView.contentInset = UIEdgeInsetsMake(-insetToAdjust.top, -insetToAdjust.left,
                                                    -insetToAdjust.bottom, -insetToAdjust.right);
  }
}
@end
