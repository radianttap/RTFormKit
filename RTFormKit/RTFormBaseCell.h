//
//  RTFormBaseCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

@import UIKit;

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
	 *	Cell with text field or text view
	 */
	RTFormCellTypeField,

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
	 */
	RTFormCellTypeMultiValuePicker,

	/**
	 *	Cell with multiple possible options, displayed using UISegmentedControl.
	 *	It has single-line title UILabel shown above the segment
	 */
	RTFormCellTypeMultiValueSegments,
};

/**
 *	Cell configuration keys
 */
typedef NS_ENUM(NSInteger, RTFormConfig) {
	/**
	 *	RTFormCell, defines cell type. Use this in the data source subclass to define what cell should be used to display particular item
	 */
	RTFormConfigCellType,

	/**
	 *	NSString, value that uniquely identifies the corresponding data source item. It's copied into @key property of the cell and thus it's accessible in the didChangeValue delegate call
	 */
	RTFormConfigKey,

	/**
	 *	NSString, title of the cell, displayed prominently
	 */
	RTFormConfigTitle,

	/**
	 *	id, current value to display. Each cell type will handle this as appropriate
	 */
	RTFormConfigValue,

	/**
	 *	NSString, placeholder value to show if there is no currently set value (think UITextField.placeholder)
	 */
	RTFormConfigPlaceholder,

	/**
	 *	NSString. If sent, cell will show multi-line UILabel below the title but above the value-handler-control. 
	 *	Usable mainly with multi-value segmented controls, if it helps. Really - this largely depends on your data
	 */
	RTFormConfigHint,

	/**
	 *	NSString. If sent, cell will show multi-line UILabel at the bottom of the cell
	 *	Use with any cell type when you need to explain that particular data / data options mean. Easy example is with RTFormCellTypeToggle where title UILabel is short one-liner
	 */
	RTFormConfigExplanation,
};

@protocol RTFormCellDelegate;
@interface RTFormBaseCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (UINib *)nib;
+ (instancetype)nibInstance;

@property (nonatomic, weak) id< RTFormCellDelegate > delegate;
@property (nonatomic) RTFormCellType cellType;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy, readonly) id value;
@property (nonatomic) BOOL enabled;

- (void)commonInit;
- (void)setupUsingConfiguration:(NSDictionary< NSNumber*,id > *)config;
- (void)applyTheme:(NSNotification *)notification;

@end



@protocol RTFormCellDelegate <NSObject>

@optional
- (void)formCell:(RTFormBaseCell *)cell didChangeValue:(id)value;

@end

NS_ASSUME_NONNULL_END