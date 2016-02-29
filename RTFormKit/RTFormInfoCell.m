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
@property (nonatomic, copy) NSString *defaultValue;

@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
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

	self.cellType = RTFormCellTypeInfo;
	self.infoLabel.textColor = [UIColor formTextMainColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];
	self.separator.hidden = YES;

	self.infoLabel.text = nil;
}

- (void)setupUsingConfiguration:(NSDictionary<NSNumber *,id> *)config {

	self.dataValue = nil;
	self.defaultValue = nil;

	[config enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		switch ((RTFormConfig)key.integerValue) {
			case RTFormConfigKey: {
				self.key = obj;
				break;
			}
			case RTFormConfigValue: {
				self.dataValue = obj;
				self.infoLabel.text = obj;
				break;
			}
			case RTFormConfigDefaultValue: {
				self.defaultValue = obj;
				if (self.dataValue.length == 0) self.infoLabel.text = obj;
				break;
			}
			case RTFormConfigDisabled: {
				self.enabled = ![(NSNumber *)obj boolValue];
				break;
			}
			default: {
				break;
			}
		}
	}];
}

@end
