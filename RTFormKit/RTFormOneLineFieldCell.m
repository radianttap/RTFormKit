//
//  RTFormOneLineFieldCell.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormOneLineFieldCell () < UITextFieldDelegate >

@property (nonatomic, copy) NSString *dataValue;

@property (nonatomic, weak) IBOutlet UIView *separator;
@property (nonatomic, weak) IBOutlet UIView *innerContentView;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, weak) IBOutlet UIView *hintContainer;
@property (nonatomic, weak) IBOutlet UILabel *hintLabel;
@property (nonatomic, weak) IBOutlet UIView *explainContainer;
@property (nonatomic, weak) IBOutlet UILabel *explainLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *hintHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *explainHeightConstraint;

@end

@implementation RTFormOneLineFieldCell

- (id)value {
	return self.dataValue;
}

- (void)awakeFromNib {
	[super awakeFromNib];

}

- (void)commonInit {
	[super commonInit];

	self.cellType = RTFormCellTypeOneLineField;
	self.textField.textColor = [UIColor formTextMainColor];
	self.hintLabel.textColor = [UIColor formTextNotabeneColor];
	self.explainLabel.textColor = [UIColor formTextSideColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];

	[self.textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setupUsingConfiguration:(NSDictionary<NSNumber *,id> *)config {

	self.hintLabel.text = nil;
	self.explainLabel.text = nil;

	self.hintHeightConstraint.active = YES;
	self.explainHeightConstraint.active = YES;

	[config enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		switch ((RTFormConfig)key.integerValue) {
			case RTFormConfigKey: {
				self.key = obj;
				break;
			}
			case RTFormConfigValue: {
				self.dataValue = obj;
				self.textField.text = obj;
				break;
			}
			case RTFormConfigPlaceholder: {
				self.textField.placeholder = obj;
				break;
			}
			case RTFormConfigHint: {
				self.hintLabel.text = obj;
				self.hintHeightConstraint.active = NO;
				break;
			}
			case RTFormConfigExplanation: {
				self.explainLabel.text = obj;
				self.explainHeightConstraint.active = NO;
				break;
			}
			default: {
				break;
			}
		}
	}];

	[self setNeedsUpdateConstraints];
}

#pragma mark - Text Field

- (void)textFieldValueChanged:(UITextField *)sender {

	self.dataValue = sender.text;

	if ([self.delegate respondsToSelector:@selector(formCell:didChangeValue:)]) {
		[self.delegate formCell:self didChangeValue:self.dataValue];
	}
}

@end
