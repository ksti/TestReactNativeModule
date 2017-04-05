//
//  GJSNativeModuleTest.h
//  GJSNativeModuleExample
//
//  Created by forp on 2017/3/24.
//  Copyright © 2017年 forp. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#else
#import "RCTBridgeModule.h"
#import "RCTEventEmitter.h"
#endif

@interface GJSNativeModuleTest : RCTEventEmitter <RCTBridgeModule>

@end
