//
//  RTFormInfoCell.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormInfoCell ()

@property (nonatomic, copy) NSString *dataValue;
@property (nonatomic, copy) NSString *subValue;
@property (nonatomic, copy) NSString *defaultValue;

@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet UILabel *sideLabel;
@property (nonatomic, weak) IBOutlet UIView *separator;

@end

@implementation RTFormInfoCell

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
	_subValue = nil;

	self.cellType = RTFormCellTypeInfo;
	self.infoLabel.textColor = [UIColor formTextMainColor];
	self.sideLabel.textColor = [UIColor formTextSideColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];
	self.separator.hidden = YES;

	self.infoLabel.text = nil;
	self.sideLabel.text = nil;
}

- (void)setupUsingConfiguration:(RTFormDataItem *)config {

	self.key = config.key;
	self.dataValue = config.value;
	self.defaultValue = config.defaultValue;
	self.subValue = config.subtitle;
	self.enabled = !config.isDisabled;

	[self updateShownValue];
}

- (void)updateShownValue {

	if (self.dataValue.length > 0) {
		self.infoLabel.text = self.dataValue;
	} else if (self.defaultValue.length > 0) {
		self.infoLabel.text = self.defaultValue;
	} else {
		self.infoLabel.text = nil;
	}

	if (self.subValue.length > 0) {
		self.sideLabel.text = self.subValue;
	} else {
		self.sideLabel.text = nil;
	}
}

@end
