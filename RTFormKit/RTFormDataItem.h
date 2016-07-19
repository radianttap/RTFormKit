//
//  RTFormDataItem.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 19.7.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <Foundation/Foundation.h>

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
	 *	NSString, title of the cell, displayed prominently
	 */
	RTFormConfigSubtitle,

	/**
	 *	id, current value to display. Each cell type will handle this as appropriate
	 */
	RTFormConfigValue,

	/**
	 *	id, value to display if actual value (above) is not yet set. Each cell type will handle this as appropriate
	 */
	RTFormConfigDefaultValue,

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

	/**
	 *	BOOL. Set this to @YES if you want to disable editing of particular field
	 */
	RTFormConfigDisabled,

	/**
	 *	BOOL. Set this to @YES if the given field must be set
	 */
	RTFormConfigMandatory,
};


@interface RTFormDataItem : NSObject

@end
