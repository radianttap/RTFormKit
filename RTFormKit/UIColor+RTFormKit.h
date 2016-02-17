//
//  UIColor+RTFormKit.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *	Define base colors for the various form elements
 */

@interface UIColor (RTFormKit)

+ (nullable UIColor *)formTintColor;

+ (UIColor *)formBackgroundColor;
+ (UIColor *)formBackgroundAlternateColor;
+ (UIColor *)formBackgroundSelectedColor;
+ (UIColor *)formBackgroundFooterColor;

+ (UIColor *)formTextHeaderColor;
+ (UIColor *)formBackgroundHeaderColor;

+ (UIColor *)formSeparatorColor;

+ (UIColor *)formTextMainColor;
+ (UIColor *)formTextSideColor;
+ (UIColor *)formTextFadeColor;
+ (UIColor *)formTextFootnoteColor;
+ (UIColor *)formTextNotabeneColor;

@end

NS_ASSUME_NONNULL_END