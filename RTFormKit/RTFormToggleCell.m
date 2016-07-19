//
//  RTFormToggleCell.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormToggleCell ()

@property (nonatomic, copy) NSNumber *dataValue;	//	@YES or @NO
@property (nonatomic, copy) NSNumber *defaultValue;

@property (nonatomic, weak) IBOutlet UIView *separator;
@property (nonatomic, weak) IBOutlet UIView *innerContentView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UISwitch *toggleSwitch;

@property (nonatomic, weak) IBOutlet UIView *hintContainer;
@property (nonatomic, weak) IBOutlet UILabel *hintLabel;
@property (nonatomic, weak) IBOutlet UIView *explainContainer;
@property (nonatomic, weak) IBOutlet UILabel *explainLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *hintHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *explainHeightConstraint;

@end

@implementation RTFormToggleCell

- (id)value {
	return self.dataValue;
}

- (void)awakeFromNib {
	[super awakeFromNib];

}

- (void)commonInit {
	[super commonInit];

	_dataValue = nil;
	_defaultValue = nil;

	self.cellType = RTFormCellTypeToggle;
	self.hintLabel.textColor = [UIColor formTextNotabeneColor];
	self.explainLabel.textColor = [UIColor formTextSideColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];
	self.separator.hidden = YES;

	self.titleLabel.textColor = [UIColor formTextMainColor];
//	[self.toggleSwitch setTintColor:[UIColor lightGrayColor]];
	[self.toggleSwitch setOnTintColor:[UIColor formTintColor]];
}

- (void)setupUsingConfiguration:(RTFormDataItem *)config {

	//	defaults
	self.titleLabel.text = nil;
	self.hintLabel.text = nil;
	self.explainLabel.text = nil;

	//	setup
	self.key = config.key;
	self.dataValue = config.value;
	self.defaultValue = config.defaultValue;
	self.enabled = !config.isDisabled;
	
	if ( config.hint ) {
		self.hintLabel.text = config.hint;
	}

	if ( config.explanation ) {
		self.explainLabel.text = config.explanation;
	}

	if ( config.title ) {
		self.titleLabel.text = config.title;
	}

	if ( self.dataValue ) {
		self.toggleSwitch.on = [self.dataValue boolValue];
	} else if ( self.defaultValue ) {
		self.toggleSwitch.on = [self.defaultValue boolValue];
	} else {
		self.toggleSwitch.on = NO;
	}

	[self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
	self.hintHeightConstraint.active = (self.hintLabel.text.length == 0);
	self.explainHeightConstraint.active = (self.explainLabel.text.length == 0);

	[super updateConstraints];
}

#pragma mark - Switch

- (IBAction)switchValueChanged:(UISwitch *)sender {

	self.dataValue = @(sender.isOn);

	if ([self.delegate respondsToSelector:@selector(formCell:didChangeValue:)]) {
		[self.delegate formCell:self didChangeValue:self.dataValue];
	}
}

@end
