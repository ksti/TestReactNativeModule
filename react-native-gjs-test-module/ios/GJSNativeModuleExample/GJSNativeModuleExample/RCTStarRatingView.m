//
//  RCTStarRatingView.m
//  GJSNativeModuleExample
//
//  Created by GJS on 2017/4/1.
//  Copyright © 2017年 forp. All rights reserved.
//

#import "RCTStarRatingView.h"

@implementation RCTStarRatingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        NSBundle *resourcesBundle = [self getResourcesBundle];
        _maximumValue = 5;
        _minimumValue = 0;
        _value = 4;
        self.tintColor = [UIColor redColor];
        _allowsHalfStars = YES;
        switch (_starImageStyle) {
            case StarImageStyleHeart:
            {
                _emptyStarImage = [[UIImage imageNamed:@"heart-empty" inBundle:resourcesBundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                _filledStarImage = [[UIImage imageNamed:@"heart-full" inBundle:resourcesBundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            }
                break;
                
            default:
                break;
        }
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews {
    [super layoutSubviews];
    [self loadStarRatingView];
}

-(void)loadStarRatingView {
    NSBundle *resourcesBundle = [self getResourcesBundle];
    HCSStarRatingView *starRatingView = [HCSStarRatingView new];
    starRatingView.maximumValue = _maximumValue;
    starRatingView.minimumValue = _minimumValue;
    starRatingView.value = _value;
    starRatingView.allowsHalfStars = _allowsHalfStars;
    starRatingView.accurateHalfStars = _accurateHalfStars;
    starRatingView.starBorderColor = _starBorderColor;
    starRatingView.starBorderWidth = _starBorderWidth;
    starRatingView.emptyStarColor = _emptyStarColor;
    starRatingView.tintColor = self.tintColor;
    starRatingView.emptyStarImage = _emptyStarImage;
    starRatingView.filledStarImage = _filledStarImage;
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:starRatingView];
    starRatingView.frame = self.bounds;
    starRatingView.backgroundColor = self.backgroundColor;
}

-(NSBundle *)getResourcesBundle {
    // Get the top level "bundle" which may actually be the framework
    NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
    
    // Check to see if the resource bundle exists inside the top level bundle
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:[mainBundle pathForResource:@"RCTStarRatingView" ofType:@"bundle"]];
    
    if (resourcesBundle == nil) {
        resourcesBundle = mainBundle;
    }
    
    return resourcesBundle;
}

- (void)didChangeValue:(HCSStarRatingView *)sender {
    _value = sender.value;
    NSLog(@"Changed rating to %.1f", sender.value);
    if (_onChange) {
        _onChange(@{@"value": @(_value),});
    }
}

@end
