//
//  RTFormSegmentsCell.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormSegmentsCell ()

@property (nonatomic, copy) NSString *dataValue;

@property (nonatomic, weak) IBOutlet UIView *separator;
@property (nonatomic, weak) IBOutlet UIView *innerContentView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, weak) IBOutlet UIView *hintContainer;
@property (nonatomic, weak) IBOutlet UILabel *hintLabel;
@property (nonatomic, weak) IBOutlet UIView *explainContainer;
@property (nonatomic, weak) IBOutlet UILabel *explainLabel;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *hintHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *explainHeightConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *verticalCenterConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *verticalSpacingConstraint;

@end

@implementation RTFormSegmentsCell

- (id)value {
	return self.dataValue;
}

- (void)awakeFromNib {
	[super awakeFromNib];

}

- (void)commonInit {
	[super commonInit];

	self.cellType = RTFormCellTypeMultiValueSegments;
	self.hintLabel.textColor = [UIColor formTextNotabeneColor];
	self.explainLabel.textColor = [UIColor formTextSideColor];
	self.separator.backgroundColor = [UIColor formSeparatorColor];

	self.titleLabel.textColor = [UIColor formTextMainColor];
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
				break;
			}
			case RTFormConfigTitle: {
				self.titleLabel.text = obj;
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

	//	populate segmented control
	[self.segmentedControl removeAllSegments];
	NSArray< NSString* > *titles = [self.dataSource titlesForMultiValueFormCell:self];
	[titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[self.segmentedControl insertSegmentWithTitle:obj atIndex:idx animated:NO];
	}];
	//	select current value
	NSArray *values = [self.dataSource valuesForMultiValueFormCell:self];
	NSInteger valueIndex = [values indexOfObject:self.dataValue];
	self.segmentedControl.selectedSegmentIndex = valueIndex;

	[self setNeedsUpdateConstraints];
}

- (void)layoutSubviews {

	//	make a first pass
	[self.innerContentView layoutIfNeeded];
	//	do title label and segmented control overlap?
	CGFloat labelRightEdge = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width;
	CGFloat segLeftEdge = self.segmentedControl.frame.origin.x;
	self.verticalCenterConstraint.active = (labelRightEdge < segLeftEdge);
	self.verticalSpacingConstraint.active = (labelRightEdge > segLeftEdge);
	//	make a second pass
	[self.innerContentView layoutIfNeeded];

	[super layoutSubviews];
}

#pragma mark - Switch

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {

	NSArray *values = [self.dataSource valuesForMultiValueFormCell:self];
	if (sender.selectedSegmentIndex >= values.count) return;

	id value = values[sender.selectedSegmentIndex];
	self.dataValue = value;

	if ([self.delegate respondsToSelector:@selector(formCell:didChangeValue:)]) {
		[self.delegate formCell:self didChangeValue:self.dataValue];
	}
}

@end
