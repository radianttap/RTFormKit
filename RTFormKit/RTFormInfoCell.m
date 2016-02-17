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

	self.cellType = RTFormCellTypeInfo;
	self.infoLabel.textColor = [UIColor formTextMainColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];
	self.separator.hidden = YES;

	self.infoLabel.text = nil;
}

- (void)setupUsingConfiguration:(NSDictionary<NSNumber *,id> *)config {

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
			default: {
				break;
			}
		}
	}];
}

@end
