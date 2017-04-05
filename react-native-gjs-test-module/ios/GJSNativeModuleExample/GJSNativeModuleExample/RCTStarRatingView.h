//
//  RCTStarRatingView.h
//  GJSNativeModuleExample
//
//  Created by GJS on 2017/4/1.
//  Copyright © 2017年 forp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HCSStarRatingView/HCSStarRatingView.h>

#if __has_include(<React/RCTComponent.h>)
#import <React/RCTComponent.h>
#else
#import "RCTComponent.h"
#endif

typedef NS_ENUM(NSInteger, StarImageStyle) {
    StarImageStyleDefault,
    StarImageStyleHeart,
};

@interface RCTStarRatingView : UIView

@property (nonatomic) IBInspectable NSUInteger maximumValue;
@property (nonatomic) IBInspectable CGFloat minimumValue;
@property (nonatomic) IBInspectable CGFloat value;
@property (nonatomic) IBInspectable CGFloat spacing;
@property (nonatomic) IBInspectable BOOL allowsHalfStars;
@property (nonatomic) IBInspectable BOOL accurateHalfStars;
@property (nonatomic) IBInspectable BOOL continuous;

@property (nonatomic) BOOL shouldBecomeFirstResponder;

// Optional: if `nil` method will return `NO`.
@property (nonatomic, copy) HCSStarRatingViewShouldBeginGestureRecognizerBlock shouldBeginGestureRecognizerBlock;

@property (nonatomic, strong) IBInspectable UIColor *starBorderColor;
@property (nonatomic) IBInspectable CGFloat starBorderWidth;

@property (nonatomic, strong) IBInspectable UIColor *emptyStarColor;

@property (nonatomic, strong) IBInspectable UIImage *emptyStarImage;
@property (nonatomic, strong) IBInspectable UIImage *halfStarImage;
@property (nonatomic, strong) IBInspectable UIImage *filledStarImage;

@property (nonatomic, assign) StarImageStyle starImageStyle;

// event block
@property (nonatomic, copy) RCTBubblingEventBlock onChange;

@end
