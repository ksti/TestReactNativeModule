//
//  IQNSString+NSAttributedString.h
//  YuanXin
//
//  Created by GJS on 2017/3/28.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NSString NSAttributedString category.
 */
@interface NSString (NSAttributedString) {
  
}

///--------------
/// @name NSAttributedString
///--------------

/**
Returns the NSString by NSAttributedString.
*/
+ (instancetype _Nonnull)stringWithAttributedString:(NSAttributedString * _Nonnull)attributedString;

/**
 Returns the NSAttributedString.
 */
@property (nonatomic, copy) NSAttributedString * _Nonnull attributedString;

@end
