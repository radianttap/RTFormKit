//
//  RTFormPickerCell.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 17.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormPickerCell () < UITableViewDataSource, UITableViewDelegate >

@property (nonatomic, copy) NSString *dataValue;
@property (nonatomic, copy) NSString *defaultValue;

@property (nonatomic, weak) IBOutlet UIView *separator;
@property (nonatomic, weak) IBOutlet UIView *innerContentView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIButton *valueButton;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (nonatomic, weak) IBOutlet UITextField *filterField;

@property (nonatomic, weak) IBOutlet UIView *hintContainer;
@property (nonatomic, weak) IBOutlet UILabel *hintLabel;
@property (nonatomic, weak) IBOutlet UIView *explainContainer;
@property (nonatomic, weak) IBOutlet UILabel *explainLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *hintHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *explainHeightConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableBottomEdgeConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *buttonBottomEdgeConstraint;

@end

@implementation RTFormPickerCell

+ (NSString *)reuseIdentifierEditing {
	return [NSStringFromClass([self class]) lowercaseString];
}

- (id)value {
	return self.dataValue;
}

- (void)awakeFromNib {
	[super awakeFromNib];

	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[self.class reuseIdentifier]];
}

- (void)commonInit {
	[super commonInit];

	_dataValue = nil;
	_defaultValue = nil;
	_valueEditingEnabled = NO;
	_autoCollapseAfterSelection = YES;

	self.cellType = RTFormCellTypeMultiValuePicker;
	self.hintLabel.textColor = [UIColor formTextNotabeneColor];
	self.explainLabel.textColor = [UIColor formTextSideColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];
	self.separator.hidden = YES;
	self.valueButton.layer.borderColor = [UIColor formTintColor].CGColor;
	self.tableView.backgroundColor = self.contentView.backgroundColor;

	self.titleLabel.textColor = [UIColor formTextMainColor];
}

- (void)prepareForReuse {
	[super prepareForReuse];

	[self.tableView reloadData];
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
				[self updateShownValue];
				break;
			}
			case RTFormConfigDefaultValue: {
				self.defaultValue = obj;
				[self updateShownValue];
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

	self.tableBottomEdgeConstraint.active = self.isValueEditingEnabled;
	self.buttonBottomEdgeConstraint.active = !self.isValueEditingEnabled;

	[super updateConstraints];
}

- (IBAction)buttonTapped:(UIButton *)sender {

	if (self.isValueEditingEnabled) {
		if ([self.delegate respondsToSelector:@selector(formCellDidDeactivate:)]) {
			[self.delegate formCellDidDeactivate:self];
		}
	} else {
		if ([self.delegate respondsToSelector:@selector(formCellDidActivate:)]) {
			[self.delegate formCellDidActivate:self];
		}
	}
}

- (void)updateShownValue {

	NSInteger indexToPreselect = NSNotFound;

	if (self.dataValue) {
		NSArray *values = [self.dataSource valuesForMultiValueFormCell:self];
		if (values.count > 0) {
			NSInteger indexOfValue = [values indexOfObject:self.dataValue];
			indexToPreselect = indexOfValue;

			if (indexOfValue != NSNotFound) {
				NSArray< NSString* > *titles = [self.dataSource titlesForMultiValueFormCell:self];
				NSString *valueTitle = titles[indexOfValue];
				[self.valueButton setTitle:valueTitle forState:UIControlStateNormal];
			}
		}

	} else {
		NSArray *values = [self.dataSource valuesForMultiValueFormCell:self];
		if (values.count > 0) {
			NSInteger indexOfValue = [values indexOfObject:self.defaultValue];
			indexToPreselect = indexOfValue;

			[self.valueButton setTitle:NSLocalizedString(@"Tap to Set", nil) forState:UIControlStateNormal];
		}
	}

	if (indexToPreselect == NSNotFound) return;
	if (!self.isValueEditingEnabled) return;

	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexToPreselect inSection:0];
	if (self.dataValue) {
		[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	}
	[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	NSArray< NSString* > *titles = [self.dataSource titlesForMultiValueFormCell:self];
	return titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSArray< NSString* > *titles = [self.dataSource titlesForMultiValueFormCell:self];

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.class reuseIdentifier] forIndexPath:indexPath];
	cell.contentView.backgroundColor = self.contentView.backgroundColor;
	cell.selectionStyle = UITableViewCellSelectionStyleDefault;
	cell.textLabel.text = titles[indexPath.row];
	cell.textLabel.backgroundColor = [UIColor clearColor];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	NSArray *values = [self.dataSource valuesForMultiValueFormCell:self];
	self.dataValue = values[indexPath.row];
	[self updateShownValue];

	if ([self.delegate respondsToSelector:@selector(formCell:didChangeValue:)]) {
		[self.delegate formCell:self didChangeValue:self.dataValue];
	}

	if (self.shouldAutoCollapseAfterSelection) {
		[self buttonTapped:nil];
	}
}

@end
