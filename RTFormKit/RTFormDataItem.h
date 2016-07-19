//
//  RTFormDataItem.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 19.7.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTFormDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTFormDataItem : NSObject

/**
 *	Defines cell type. Use this in the your tableView:cellForRowAtIndexPath: to instantiate cell of proper type
 */
@property (nonatomic) RTFormCellType cellType;

/**
 *	NSString, value that uniquely identifies the corresponding data source item.
 *	It's copied into @key property of the cell and thus it's accessible in the didChangeValue delegate call
 */
@property (nonatomic, copy, nonnull) NSString *key;

/**
 *	NSString, title of the cell, displayed prominently
 *	Default is nil.
 */
@property (nonatomic, copy, nullable) NSString *title;

/**
 *	NSString, title of the cell, displayed prominently
 *	Default is nil.
 */
@property (nonatomic, copy, nullable) NSString *subtitle;

/**
 *	id, current value to display. Each cell type will handle this as appropriate
 *	Default is nil.
 */
@property (nonatomic, strong, nullable) id value;

/**
 *	id, value to display if actual value (above) is not yet set. Each cell type will handle this as appropriate
 *	Default is nil.
 */
@property (nonatomic, strong, nullable) id defaultValue;

/**
 *	NSString, placeholder value to show if there is no currently set value (think UITextField.placeholder)
 *	Default is nil.
 */
@property (nonatomic, copy, nullable) NSString *placeholder;

/**
 *	NSString. If sent, cell will show multi-line UILabel below the title but above the value-handler-control.
 *	Usable mainly with multi-value segmented controls, if it helps. Really - this largely depends on your data
 *	Default is nil.
 */
@property (nonatomic, copy, nullable) NSString *hint;

/**
 *	NSString. If sent, cell will show multi-line UILabel at the bottom of the cell
 *	Use with any cell type when you need to explain that particular data / data options mean. Easy example is with RTFormCellTypeToggle where title UILabel is short one-liner
 *	Default is nil.
 */
@property (nonatomic, copy, nullable) NSString *explanation;

/**
 *	BOOL. Set this to @YES if you want to disable editing of particular field
 *	Default is NO.
 */
@property (nonatomic, getter=isDisabled) BOOL disabled;

/**
 *	BOOL. Set this to @YES if the given field must be set
 *	Default is NO.
 */
@property (nonatomic, getter=isMandatory) BOOL mandatory;

@end

NS_ASSUME_NONNULL_END
