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
				break;
			}
			case RTFormConfigExplanation: {
				self.explainLabel.text = obj;
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

	//	now that content is known, do internal layout pass to figure out do we need to switch to two-line layout
	[self.innerContentView layoutIfNeeded];
	//	however, this is done using whatever frame was set in .xib file (I usually go with 320 width)
	//	thus this will yield proper sizes - unless label or segmented are larger than 320, in which case you shoudl not be using this type of cell
	//	but origins for segmented will be wrong and way too small, thus additional translations are required in updateConstraints

	[self setNeedsUpdateConstraints];
}

//	ISSUE: remaining problem is layout is not adjusted on rotation (portrait, to landscape, then portrait)
- (void)updateConstraints {
	//	this method is called twice for the cell

	//	here - in the 2nd layout pass - contentView will have proper width set (320 or 375 or whatever)
	//	so use that to calculate would horizontal layout fit
	CGFloat labelRightEdge = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width;
	CGFloat segLeftEdge = self.contentView.frame.size.width - self.contentView.layoutMargins.right - self.segmentedControl.frame.size.width;
	BOOL useHorizontalLayout = (labelRightEdge < segLeftEdge);
	//	YES == title label and segmented control are in one line
	//	NO  == title label is above the segmented control
	self.verticalCenterConstraint.active = useHorizontalLayout;
	self.verticalSpacingConstraint.active = !useHorizontalLayout;

	self.hintHeightConstraint.active = (self.hintLabel.text.length == 0);
	self.explainHeightConstraint.active = (self.explainLabel.text.length == 0);
	[super updateConstraints];
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
