//
//  UIColor+RTFormKit.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "UIColor+RTFormKit.h"

@implementation UIColor (RTFormKit)

+ (UIColor *)formTintColor {
	return nil;
}

+ (UIColor *)formBackgroundColor {
	return [UIColor whiteColor];
}

+ (UIColor *)formBackgroundAlternateColor {
	return [[UIColor lightGrayColor] colorWithAlphaComponent:.1];
}

+ (UIColor *)formBackgroundSelectedColor {
	return [UIColor colorWithRed:.92 green:.94 blue:.96 alpha:1];
}

+ (UIColor *)formBackgroundFooterColor {
	return [UIColor whiteColor];
}




+ (UIColor *)formTextHeaderColor {
	return [UIColor whiteColor];
}

+ (UIColor *)formBackgroundHeaderColor {
	return [UIColor colorWithRed:.6 green:.63 blue:.96 alpha:1];
}




+ (UIColor *)formSeparatorColor {
	return [UIColor formBackgroundHeaderColor];
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
