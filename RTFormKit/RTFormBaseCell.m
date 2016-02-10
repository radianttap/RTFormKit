//
//  RTFormBaseCell.m
//  FormKitDemo
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormBaseCell.h"

@implementation RTFormBaseCell

+ (NSString *)reuseIdentifier {
	return [NSStringFromClass([self class]) uppercaseString];
}

+ (UINib *)nib {
	return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (instancetype)nibInstance {
	return [[[self nib] instantiateWithOwner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
	[super awakeFromNib];

}

@end
