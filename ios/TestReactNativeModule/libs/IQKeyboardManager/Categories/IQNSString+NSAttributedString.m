//
//  IQNSString+NSAttributedString.m
//  YuanXin
//
//  Created by GJS on 2017/3/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "IQNSString+NSAttributedString.h"
#import <objc/runtime.h>

static void *IQAttributedStringKey;

@implementation NSString (NSAttributedString)

+ (instancetype)stringWithAttributedString:(NSAttributedString *)attributedString {
  NSString *string = [attributedString string];
  string.attributedString = attributedString;
  return string;
}

- (void)setAttributedString:(NSAttributedString *)attributedString {
  objc_setAssociatedObject(self, &IQAttributedStringKey, attributedString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSAttributedString *)attributedString {
  NSAttributedString *attributedString = objc_getAssociatedObject(self, &IQAttributedStringKey);
  if (attributedString == nil) {
    // do a lot of stuff
    attributedString = [[NSAttributedString alloc] initWithString:@""];
    objc_setAssociatedObject(self, &IQAttributedStringKey, attributedString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return attributedString;
}

@end
