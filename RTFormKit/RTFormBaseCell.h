//
//  RTFormBaseCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

@import UIKit;
#import "RTFormDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *	Defines what kind of a cell this is (text only, text field, toggle, slider, multi-value etc.
 */
typedef NS_ENUM(NSInteger, RTFormCellType) {
	/**
	 *	Base cell. never used this directly
	 */
	RTFormCellTypeUnknown,

	/**
	 *	Cell with just one multi-line UILabel
	 */
	RTFormCellTypeInfo,

	/**
	 *	Cell with text field
	 */
	RTFormCellTypeOneLineField,

	/**
	 *	Cell with inline-date picker, shown on tap
	 */
	RTFormCellTypeDatePicker,

	/**
	 *	Cell with text view
	 */
	RTFormCellTypeMultiLineField,

	/**
	 *	Cell with single-line UILabel on the leading side and UISwitch on the trailing side
	 */
	RTFormCellTypeToggle,

	/**
	 *	Cell with single-line UILabel above and UISlider below, allowing to pick from a range of values
	 */
	RTFormCellTypeRange,

	/**
	 *	Cell with multiple possible options. When you tap the value, it expands to reveal picker with list of possible options
	 *	This picker is implemented as simple nested table view. If there are more than 10 options, it also shows a text field to filter the list of options
	 */
	RTFormCellTypeMultiValuePicker,

	/**
	 *	Cell with multiple possible options, displayed using UISegmentedControl.
	 *	It has single-line title UILabel shown above the segment
	 */
	RTFormCellTypeMultiValueSegments,
};




/**
 *	Base cell for all other form cells
 */
@interface RTFormBaseCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (UINib *)nib;
+ (instancetype)nibInstance;

@property (nonatomic, weak) id< RTFormCellDelegate > delegate;
@property (nonatomic, weak) id< RTFormCellDataSource > dataSource;

@property (nonatomic) RTFormCellType cellType;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy, readonly) id value;
@property (nonatomic) BOOL enabled;

- (void)commonInit;
- (void)setupUsingConfiguration:(NSDictionary< NSNumber*,id > *)config;
- (void)applyTheme:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
