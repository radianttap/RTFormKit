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

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (!self) return nil;

	//	let table view decide the background colors
	self.backgroundColor = [UIColor clearColor];
	self.contentView.backgroundColor = [UIColor clearColor];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.clipsToBounds = YES;

	//	prepare row for self-sizing
	NSDictionary *metrics = @{@"rowHeight": @(54)};
	NSDictionary *vd = @{@"cv": self.contentView};
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cv(rowHeight@749)]"
																			 options:0
																			 metrics:metrics
																			   views:vd]];

	[self commonInit];
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];

	[self commonInit];
}

- (void)commonInit {

}

#pragma mark -

@end
