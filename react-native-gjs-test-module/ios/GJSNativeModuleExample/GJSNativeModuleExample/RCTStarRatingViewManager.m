//
//  RCTStarRatingViewManager.m
//  GJSNativeModuleExample
//
//  Created by GJS on 2017/4/1.
//  Copyright © 2017年 forp. All rights reserved.
//

#import "RCTStarRatingViewManager.h"

#if __has_include(<React/RCTConvert.h>)
#import <React/RCTConvert.h>
#import <React/RCTBridge.h>
#import <React/RCTImageSource.h>
#import <React/RCTImageLoader.h>
#else
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTImageSource.h"
#import "RCTImageLoader.h"
#endif

#import "RCTStarRatingView.h"

#pragma mark - StarRatingView Enum

typedef NS_ENUM(NSInteger, SRVOverflow) {
    SRVOverflowHidden,
    SRVOverflowVisible,
    SRVOverflowScroll,
};

@implementation RCTConvert (RCTStarRatingViewManager)

RCT_ENUM_CONVERTER(StarImageStyle, (@{
                                  @"star": @(StarImageStyleDefault),
                                  @"heart": @(StarImageStyleHeart),
                                  }), StarImageStyleDefault, intValue)

RCT_ENUM_CONVERTER(SRVOverflow, (@{
                                  @"hidden": @(SRVOverflowHidden),
                                  @"visible": @(SRVOverflowVisible),
                                  @"scroll": @(SRVOverflowScroll),
                                  }), SRVOverflowVisible, intValue)

@end

@interface RCTStarRatingViewManager()

@end

#pragma mark - CustomErrorDomain
#define CustomErrorDomain @"com.gjs.test"
typedef enum {
    　　  XDefultFailed = -1000,
    　　  XGetImageSourceFailed,
}CustomErrorFailed;

@implementation RCTStarRatingViewManager

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE()

/**
 * This method instantiates a native view to be managed by the module. Override
 * this to return a custom view instance, which may be preconfigured with default
 * properties, subviews, etc. This method will be called many times, and should
 * return a fresh instance each time. The view module MUST NOT cache the returned
 * view and return the same instance for subsequent calls.
 */
- (UIView *)view
{
    RCTStarRatingView *starRatingView = [[RCTStarRatingView alloc] init];
//    starRatingView.onChange = ^(NSDictionary *body) {
//        //
//    };
    
    return starRatingView;
}

//- (void)onChange:(RCTStarRatingView *)sender
//{
//    if (sender.onChange) {
//        sender.onChange(@{ @"value": @(sender.value) });
//    }
//}

#pragma mark - View properties

RCT_EXPORT_VIEW_PROPERTY(maximumValue, NSUInteger)
RCT_EXPORT_VIEW_PROPERTY(minimumValue, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(value, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(spacing, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(allowsHalfStars, BOOL)
RCT_EXPORT_VIEW_PROPERTY(accurateHalfStars, BOOL)
RCT_EXPORT_VIEW_PROPERTY(continuous, BOOL)
RCT_CUSTOM_VIEW_PROPERTY(starBorderColor, UIColor, RCTStarRatingView)
{
    view.starBorderColor = [RCTConvert UIColor:json] ?: defaultView.starBorderColor;
}
RCT_EXPORT_VIEW_PROPERTY(starBorderWidth, CGFloat)
RCT_CUSTOM_VIEW_PROPERTY(emptyStarColor, UIColor, RCTStarRatingView)
{
    view.emptyStarColor = [RCTConvert UIColor:json] ?: defaultView.emptyStarColor;
}
RCT_REMAP_VIEW_PROPERTY(filledStarColor, tintColor, UIColor)
RCT_CUSTOM_VIEW_PROPERTY(emptyStarImage, RCTImageSource, RCTStarRatingView) {
    [self loadImageWithJson:json completion:^(NSError *error, UIImage *image) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                view.emptyStarImage = image;
            });
        }
    }];
}
RCT_CUSTOM_VIEW_PROPERTY(halfStarImage, RCTImageSource, RCTStarRatingView) {
    [self loadImageWithJson:json completion:^(NSError *error, UIImage *image) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                view.halfStarImage = image;
            });
        }
    }];
}
RCT_CUSTOM_VIEW_PROPERTY(filledStarImage, RCTImageSource, RCTStarRatingView) {
    [self loadImageWithJson:json completion:^(NSError *error, UIImage *image) {
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                view.filledStarImage = image;
            });
        }
    }];
}
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock);

RCT_REMAP_VIEW_PROPERTY(shouldBeFirstResponder, shouldBecomeFirstResponder, BOOL)
RCT_CUSTOM_VIEW_PROPERTY(starImageStyle, StarImageStyle, RCTStarRatingView)
{
    if (json) {
        view.starImageStyle = [RCTConvert StarImageStyle:json];
    } else {
        //
    }
}
RCT_CUSTOM_VIEW_PROPERTY(overflow, SRVOverflow, RCTStarRatingView)
{
    if (json) {
        view.clipsToBounds = [RCTConvert SRVOverflow:json] != SRVOverflowVisible;
    } else {
        view.clipsToBounds = defaultView.clipsToBounds;
    }
}

-(void)loadImageWithJson:(id)json completion:(void(^)(NSError *, UIImage *))completionHandler {
    RCTImageSource *imageSource = [RCTConvert RCTImageSource:json];
    if (imageSource && _bridge.imageLoader) {
        [_bridge.imageLoader loadImageWithURLRequest:imageSource.request size:imageSource.size scale:imageSource.scale clipped:NO resizeMode:UIViewContentModeScaleToFill progressBlock:^(int64_t progress, int64_t total) {
            // progressBlock
        } partialLoadBlock:^(UIImage *image) {
            // partialLoadBlock
        } completionBlock:^(NSError *error, UIImage *image) {
            // completionBlock
            if (completionHandler) {
                completionHandler(error, image);
            }
        }];
    }
    else {
        //
        if (completionHandler) {
            completionHandler([NSError errorWithDomain:CustomErrorDomain code:XGetImageSourceFailed userInfo:[NSDictionary dictionaryWithObject:@"either imageSource or _bridge.imageLoader is null " forKey:NSLocalizedDescriptionKey]], nil);
        }
    }
}

@end
