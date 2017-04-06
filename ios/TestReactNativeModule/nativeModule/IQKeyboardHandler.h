//
//  IQKeyboardHandler.h
//  YuanXin
//
//  Created by forp on 2017/3/24.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

#import "IQKeyboardManager.h"

@interface IQKeyboardHandler : NSObject <RCTBridgeModule>

@end
