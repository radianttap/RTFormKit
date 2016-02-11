//
//  RTFormHeader.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "UIColor+RTFormKit.h"
#import "RTFormHeader.h"

@interface RTFormHeader ()

@property (nonatomic, weak) IBOutlet UIView *innerContentView;

@end

@implementation RTFormHeader

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

	self.innerContentView.backgroundColor = [UIColor formBackgroundHeaderColor];
	self.titleLabel.textColor = [UIColor formTextMainColor];
}

@end
