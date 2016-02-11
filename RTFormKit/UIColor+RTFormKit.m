//
//  UIColor+RTFormKit.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "UIColor+RTFormKit.h"

@implementation UIColor (RTFormKit)

+ (UIColor *)formBackgroundColor {
	return [UIColor whiteColor];
}

+ (UIColor *)formBackgroundAlternateColor {
	return [[UIColor lightGrayColor] colorWithAlphaComponent:.1];
}

+ (UIColor *)formBackgroundSelectedColor {
	return [UIColor colorWithRed:.92 green:.94 blue:.96 alpha:1];
}

+ (UIColor *)formBackgroundHeaderColor {
	return [UIColor colorWithRed:.92 green:.94 blue:.96 alpha:1];
}

+ (UIColor *)formBackgroundFooterColor {
	return [UIColor whiteColor];
}


+ (UIColor *)formSeparatorColor {
	return [UIColor lightGrayColor];
}


+ (UIColor *)formTextMainColor {
	return [UIColor darkTextColor];
}

+ (UIColor *)formTextSideColor {
	return [[UIColor darkTextColor] colorWithAlphaComponent:.6];
}

+ (UIColor *)formTextFadeColor {
	return [UIColor lightGrayColor];
}

+ (UIColor *)formTextFootnoteColor {
	return [UIColor lightGrayColor];
}

+ (UIColor *)formTextNotabeneColor {
	return [UIColor darkGrayColor];
}


@end
