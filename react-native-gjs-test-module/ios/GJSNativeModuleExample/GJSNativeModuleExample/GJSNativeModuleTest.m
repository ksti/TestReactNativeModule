//
//  GJSNativeModuleTest.m
//  GJSNativeModuleExample
//
//  Created by forp on 2017/3/24.
//  Copyright © 2017年 forp. All rights reserved.
//

#import "GJSNativeModuleTest.h"

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTBridge.h>
#import <React/RCTImageLoader.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>
#else
#import "RCTBridgeModule.h"
#import "RCTBridge.h"
#import "RCTConvert.h"
#import "RCTEventDispatcher.h"
#import "RCTBridge.h"
#import "RCTImageLoader.h"
#import "RCTLog.h"
#import "RCTUtils.h"
#endif

#pragma mark - Test_NS_ENUM
typedef NS_ENUM(NSInteger, Test_NS_ENUM) {
    TestEnumOne,
    TestEnumTwo,
    TestEnumThree,
};

@implementation RCTConvert (Test_NS_ENUM)

RCT_ENUM_CONVERTER(Test_NS_ENUM, (@{ @"testEnumOne" : @(TestEnumOne),
                                     @"testEnumTwo" : @(TestEnumTwo),
                                     @"testEnumThree" : @(TestEnumThree)}),
                   TestEnumOne, integerValue)

@end

@interface GJSNativeModuleTest() {
}

@property (nonatomic, assign) BOOL hasListeners;

@end

@implementation GJSNativeModuleTest

RCT_EXPORT_MODULE(GJSTestModule);

/**
 * The queue that will be used to call all exported methods. If omitted, this
 * will call on a default background queue, which is avoids blocking the main
 * thread.
 *
 * If the methods in your module need to interact with UIKit methods, they will
 * probably need to call those on the main thread, as most of UIKit is main-
 * thread-only. You can tell React Native to call your module methods on the
 * main thread by returning a reference to the main queue, like this:
 *
 * - (dispatch_queue_t)methodQueue
 * {
 *   return dispatch_get_main_queue();
 * }
 *
 * If you don't want to specify the queue yourself, but you need to use it
 * inside your class (e.g. if you have internal methods that need to dispatch
 * onto that queue), you can just add `@synthesize methodQueue = _methodQueue;`
 * and the bridge will populate the methodQueue property for you automatically
 * when it initializes the module.
 */
- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

/**
 * Injects constants into JS. These constants are made accessible via
 * NativeModules.ModuleName.X.  It is only called once for the lifetime of the
 * bridge, so it is not suitable for returning dynamic values, but may be used
 * for long-lived values such as session keys, that are regenerated only as
 * part of a reload of the entire React application.
 */
- (NSDictionary *)constantsToExport {
    return @{ @"ModuleAuthor" : @"GJS",
              @"ModuleGitHub": @"",
              @"testEnum1" : @(TestEnumOne),
              @"testEnum2" : @(TestEnumTwo),
              @"testEnum3" : @(TestEnumThree)
              };
}

/**
 * Override this method to return an array of supported event names. Attempting
 * to observe or send an event that isn't included in this list will result in
 * an error.
 */
- (NSArray<NSString *> *)supportedEvents
{
    return @[@"EventReminder"];
}

// 在添加第一个监听函数时触发
-(void)startObserving {
    _hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    _hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}

/**
 *  test respond method
 *
 *  @param NSString *name
 *
 *  @return
 */
RCT_REMAP_METHOD(testRespondMethod,
                 name:(NSString *)name
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    if([self respondsToSelector:NSSelectorFromString(name)]) {
        // after 3 sec, for test.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            NSLog(@"3s以后---");
            resolve(@YES);
        });
        //resolve(@YES);
    }
    else {
        reject(@"-1001", @"not respond this method", nil);
    }
    
    [self testEmitter];
}

- (void)testEmitter {
    //NSString *eventName = notification.userInfo[@"name"];
    NSString *eventName = @"test name";
    if (_hasListeners) { // Only send events if anyone is listening
        [self sendEventWithName:@"EventReminder" body:@{@"name": eventName}];
    }
}


@end
