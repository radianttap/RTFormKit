//
//  RTFormDateCell.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 13.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormDateCell ()

@property (nonatomic, copy) NSDate *dataValue;
@property (nonatomic, copy) NSDate *defaultValue;

@property (nonatomic, weak) IBOutlet UIView *separator;
@property (nonatomic, weak) IBOutlet UIView *innerContentView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *dateButton;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, weak) IBOutlet UIView *hintContainer;
@property (nonatomic, weak) IBOutlet UILabel *hintLabel;
@property (nonatomic, weak) IBOutlet UIView *explainContainer;
@property (nonatomic, weak) IBOutlet UILabel *explainLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *hintHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *explainHeightConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *pickerBottomEdgeConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *buttonBottomEdgeConstraint;

@end

@implementation RTFormDateCell

+ (NSString *)reuseIdentifierEditing {
	return [NSStringFromClass([self class]) lowercaseString];
}

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

	_dateEditingEnabled = NO;
	self.cellType = RTFormCellTypeDatePicker;
	self.hintLabel.textColor = [UIColor formTextNotabeneColor];
	self.explainLabel.textColor = [UIColor formTextSideColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];
	self.separator.hidden = YES;
	self.dateButton.layer.borderColor = [UIColor formTintColor].CGColor;

	self.titleLabel.textColor = [UIColor formTextMainColor];
}

- (void)setupUsingConfiguration:(NSDictionary<NSNumber *,id> *)config {

	self.hintLabel.text = nil;
	self.explainLabel.text = nil;

	[config enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		switch ((RTFormConfig)key.integerValue) {
			case RTFormConfigKey: {
				self.key = obj;
				break;
			}
			case RTFormConfigValue: {
				self.dataValue = obj;
				self.datePicker.date = obj;
				[self updateShownDate];
				break;
			}
			case RTFormConfigDefaultValue: {
				self.defaultValue = obj;
				if (!self.dataValue) {
					self.datePicker.date = obj;
					[self updateShownDate];
				}
				break;
			}
			case RTFormConfigTitle: {
				self.titleLabel.text = obj;
				break;
			}
			case RTFormConfigHint: {
				self.hintLabel.text = obj;
				break;
			}
			case RTFormConfigExplanation: {
				self.explainLabel.text = obj;
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

	[self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
	self.hintHeightConstraint.active = (self.hintLabel.text.length == 0);
	self.explainHeightConstraint.active = (self.explainLabel.text.length == 0);

	self.pickerBottomEdgeConstraint.active = self.isDateEditingEnabled;
	self.buttonBottomEdgeConstraint.active = !self.isDateEditingEnabled;

	[super updateConstraints];
}

#pragma mark - Date Picker

- (IBAction)pickerValueChanged:(UIDatePicker *)sender {

	self.dataValue = sender.date;
	[self updateShownDate];

	if ([self.delegate respondsToSelector:@selector(formCell:didChangeValue:)]) {
		[self.delegate formCell:self didChangeValue:self.dataValue];
	}
}

- (void)updateShownDate {

	if (self.dataValue) {
		if (self.dateFormatter) {
			[self.dateButton setTitle:[self.dateFormatter stringFromDate:self.dataValue] forState:UIControlStateNormal];
		} else {
			[self.dateButton setTitle:[self.dataValue description] forState:UIControlStateNormal];
		}
	} else {
		[self.dateButton setTitle:NSLocalizedString(@"Tap to Set", nil) forState:UIControlStateNormal];
	}
}

- (IBAction)buttonTapped:(UIButton *)sender {

	if (self.isDateEditingEnabled) {
		if ([self.delegate respondsToSelector:@selector(formCellDidDeactivate:)]) {
			[self.delegate formCellDidDeactivate:self];
		}
	} else {
		if ([self.delegate respondsToSelector:@selector(formCellDidActivate:)]) {
			[self.delegate formCellDidActivate:self];
		}
	}
}

@end
