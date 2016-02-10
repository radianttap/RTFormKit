//
//  UIColor+RTFormKit.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	Define base colors for the various form elements
 */

@interface UIColor (RTFormKit)

+ (UIColor *)formBackgroundColor;
+ (UIColor *)formBackgroundAlternateColor;
+ (UIColor *)formBackgroundSelectedColor;
+ (UIColor *)formBackgroundHeaderColor;
+ (UIColor *)formBackgroundFooterColor;

+ (UIColor *)formTextMainColor;
+ (UIColor *)formTextSideColor;
+ (UIColor *)formTextFadeColor;
+ (UIColor *)formTextFootnoteColor;
+ (UIColor *)formTextNotabeneColor;

@end
