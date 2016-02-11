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

@end

@implementation RTFormInfoCell

- (id)value {
	return self.dataValue;
}

- (void)awakeFromNib {
	[super awakeFromNib];

}

- (void)setupUsingConfiguration:(NSDictionary<NSNumber *,id> *)config {

	[config enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		switch ((RTFormConfig)key.integerValue) {
			case RTFormConfigCellType: {
				self.cellType = (RTFormCellType)[obj integerValue];
				break;
			}
			case RTFormConfigKey: {
				self.key = obj;
				break;
			}
			case RTFormConfigTitle: {
				break;
			}
			case RTFormConfigValue: {
				self.infoLabel.text = obj;
				break;
			}
			case RTFormConfigPlaceholder: {
				break;
			}
			case RTFormConfigHint: {
				break;
			}
			case RTFormConfigExplanation: {
				break;
			}
		}
	}];
}

@end
