//
//  IQKeyboardHandler.m
//  YuanXin
//
//  Created by forp on 2017/3/24.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "IQKeyboardHandler.h"
#import "IQNSString+NSAttributedString.h"

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTConvert.h>
#import <React/RCTAssert.h>
#else
#import "RCTConvert.h"
#import "RCTAssert.h"
#endif

#define ERROR_IQKEYBOARD_INVALID_COLOR_STRING_KEY @"invalid_color_string"
#define ERROR_IQKEYBOARD_INVALID_COLOR_STRING_MSG @"an invalid color string specified by textStyle: color."

#define ERROR_IQKEYBOARD_INVALID_FONT_SIZE_KEY @"invalid_font_size"
#define ERROR_IQKEYBOARD_INVALID_FONT_SIZE_MSG @"an invalid font size specified by textStyle: fontSize."

@interface IQKeyboardHandler()

/*******************************************/

/** used as a flag rejected. */
@property(nonatomic, assign) BOOL rejected;

/*******************************************/

@end

@implementation IQKeyboardHandler

static NSDictionary *colorStringDic = nil;
__attribute__((constructor))
static void initialize_colorStringDic() {
  colorStringDic = @{@"BLACK": [UIColor blackColor],
                     @"DARKGRAY": [UIColor darkGrayColor],
                     @"LIGHTGRAY": [UIColor lightGrayColor],
                     @"WHITE": [UIColor whiteColor],
                     @"GRAY": [UIColor grayColor],
                     @"RED": [UIColor redColor],
                     @"ORANGE": [UIColor orangeColor],
                     @"YELLOW": [UIColor yellowColor],
                     @"GREEN": [UIColor greenColor],
                     @"BLUE": [UIColor blueColor],
                     @"CYAN": [UIColor cyanColor],
                     @"PURPLE": [UIColor purpleColor],
                     @"BROWN": [UIColor brownColor],
                     @"MAGENTA": [UIColor magentaColor],
                     @"CLEAR": [UIColor clearColor],
                     @"TRANSPARENT": [UIColor clearColor]};
}

__attribute__((destructor))
static void destroy_colorStringDic() {
  colorStringDic = nil;
}

// initialize is a class method which will be called before any other method is called on your class.
// 最先调用，包括在静态代码执行之前，顺序依次是：
// 1. + (void)initialize
// 2. static code
// 3. - (instancetype)init
+ (void)initialize {
  // NSLog(@"+ (void)initialize");
  /*
  if(!colorStringDic)
  {
    colorStringDic = @{@"BLACK": [UIColor blackColor],
                       @"DARKGRAY": [UIColor darkGrayColor],
                       @"LIGHTGRAY": [UIColor lightGrayColor],
                       @"WHITE": [UIColor whiteColor],
                       @"GRAY": [UIColor grayColor],
                       @"RED": [UIColor redColor],
                       @"ORANGE": [UIColor orangeColor],
                       @"YELLOW": [UIColor yellowColor],
                       @"GREEN": [UIColor greenColor],
                       @"BLUE": [UIColor blueColor],
                       @"CYAN": [UIColor cyanColor],
                       @"PURPLE": [UIColor purpleColor],
                       @"BROWN": [UIColor brownColor],
                       @"MAGENTA": [UIColor magentaColor],
                       @"CLEAR": [UIColor clearColor],
                       @"TRANSPARENT": [UIColor clearColor]};
  }
   */
}

- (instancetype)init
{
  // NSLog(@"- (instancetype)init"); //
  self = [super init];
  if (self) {
    //
  }
  return self;
}


RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

/**
 *  IQKeyboardManager 设置 doneBarButtonItemText
 *
 *  @param enable 是否启用 enableAutoToolbar
 *  @param doneText 设置“完成”文本
 *  @param textStyle 设置“完成”文本样式，目前仅支持{color, fontSize}
 *  @param resolver 成功时回调
 *  @param rejecter 失败时回调
 *
 *  @return
 */
RCT_EXPORT_METHOD(setEnableAutoToolbar:(BOOL)enable doneBarButtonItemText:(NSString *)doneText doneTextStyle:(NSDictionary *)textStyle resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  IQKeyboardManager *managerKB = [IQKeyboardManager sharedManager];
  [managerKB setEnable:true];
  doneText = doneText.length > 0 ? doneText : @"完成";
  managerKB.enableAutoToolbar = enable;
  managerKB.toolbarDoneBarButtonItemText = doneText;
  
  if (textStyle) {
    // 设置标签文字
    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:doneText];
    // 获取需要标记的位置和长度
    NSRange range = [doneText rangeOfString:doneText];
    // 自定义textStyle
    NSString *strTextColor = [RCTConvert NSString:textStyle[@"color"]];
    if (!strTextColor) {
      strTextColor = @"#000000";
    }
    UIColor *textColor = [self colorWithString:strTextColor resolver:resolve rejecter:reject];
    if (!textColor) {
      if (reject) {
        reject(ERROR_IQKEYBOARD_INVALID_COLOR_STRING_KEY, ERROR_IQKEYBOARD_INVALID_COLOR_STRING_MSG, nil);
      }
      return; // rejected then return
    }
    
    CGFloat fontSize = [RCTConvert CGFloat:textStyle[@"fontSize"]];
    if (fontSize <= 0) {
      //fontSize = [UIFont systemFontSize];
      fontSize = 15;
    }
    if (textColor && !fontSize) {
      if (reject) {
        reject(ERROR_IQKEYBOARD_INVALID_FONT_SIZE_KEY, ERROR_IQKEYBOARD_INVALID_FONT_SIZE_MSG, nil);
        return; // rejected then return
      }
    }
    
    if (textColor && fontSize) {
      UIFont *textFont = [UIFont systemFontOfSize:fontSize];
      if (![RCTConvert BOOL:textStyle[@"bold"]]) {
        textFont = [UIFont boldSystemFontOfSize:fontSize];
      }
      // 设置被标记文字的属性
      [attrituteString setAttributes:@{NSForegroundColorAttributeName : textColor,   NSFontAttributeName : textFont} range : range];
      managerKB.toolbarDoneBarButtonItemText = [NSString stringWithAttributedString:attrituteString];
    }
  }
  
  if (resolve) {
    resolve(nil);
  }
}

/**
 *  IQKeyboardManager 配置属性
 *
 *  @param options 配置属性
 *  @param resolver 成功时回调
 *  @param rejecter 失败时回调
 *
 *  @return
 */
RCT_EXPORT_METHOD(setIQKeyboardOptions:(NSDictionary *)options resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
  IQKeyboardManager *managerKB = [IQKeyboardManager sharedManager];
  BOOL enable = [RCTConvert BOOL:options[@"enable"]];
  [managerKB setEnable:true];
  BOOL enableAutoToolbar = [RCTConvert BOOL:options[@"enableAutoToolbar"]];
  managerKB.enableAutoToolbar = enableAutoToolbar;
  
  if (enable && enableAutoToolbar) {
    NSString *doneText = [RCTConvert NSString:options[@"doneText"]];
    managerKB.toolbarDoneBarButtonItemText = doneText.length > 0 ? doneText : @"完成";
    BOOL shouldShowTextFieldPlaceholder = [RCTConvert BOOL:options[@"shouldShowTextFieldPlaceholder"]];
    managerKB.shouldShowTextFieldPlaceholder = shouldShowTextFieldPlaceholder;
  }
}

#pragma mark - utils
// 颜色
#define Color_rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define Color_rgb(r,g,b) Color_rgba(r, g, b, 1.0f)
// 16进制颜色值
#define DEFAULT_VOID_COLOR [UIColor blackColor]
- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
  NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  
  
  if ([cString length] < 6)
    return DEFAULT_VOID_COLOR;
  if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
  if ([cString length] != 6)
    return DEFAULT_VOID_COLOR;
  
  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];
  
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:((float) r / 255.0f)
                         green:((float) g / 255.0f)
                          blue:((float) b / 255.0f)
                         alpha:1.0f];
}

// 颜色字符串转颜色值
- (UIColor *)colorWithString:(NSString *)stringToConvert resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject
{
  NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  
  
  UIColor *handledColor = nil;
  // #f5fcff
  if ([cString hasPrefix:@"#"]) {
    handledColor = [self colorWithHexString:cString];
  }
  // rgba(0, 0, 0, 0.8)
  else if ([cString hasPrefix:@"RGBA"]) {
    NSUInteger location = [cString rangeOfString:@"RGBA("].location;
    NSUInteger length = (cString.length-1)-(location+1);
    if (location != NSNotFound) {
      NSString *rgbaStr = [cString substringWithRange:NSMakeRange(location, length)];
      NSArray *rgbaArray = [rgbaStr componentsSeparatedByString:@","];
      if ([rgbaArray count] == 4) {
        handledColor = Color_rgba([rgbaArray[0] integerValue], [rgbaArray[1] integerValue], [rgbaArray[2] integerValue], [rgbaArray[3] floatValue]);
      }
    }
  }
  else if ([cString hasPrefix:@"RGB"]) {
    NSUInteger location = [cString rangeOfString:@"RGB("].location;
    NSUInteger length = (cString.length-1)-(location+1);
    if (location != NSNotFound) {
      NSString *rgbaStr = [cString substringWithRange:NSMakeRange(location, length)];
      NSArray *rgbaArray = [rgbaStr componentsSeparatedByString:@","];
      if ([rgbaArray count] >= 3) {
        handledColor = Color_rgba([rgbaArray[0] integerValue], [rgbaArray[1] integerValue], [rgbaArray[2] integerValue], 1.0f);
      }
    }
  }
  else {
    handledColor = colorStringDic[cString];
  }
  
  return handledColor;
}

@end
