//
//  RTFormDataSource.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

@import UIKit;

@class RTFormBaseCell;

@protocol RTFormCellDataSource <NSObject>

@optional
/**
 *	Data Source for inner table view inside the expanded multi-value picker
 *
 *	@param cell	A multi-value subclass of RTFormBaseCell (usually Segments or Picker)
 *
 *	@return Array of actual model data objects. Must correspond to value and defaultValue keys in the cell configuration
 */
- (NSArray *)valuesForMultiValueFormCell:(RTFormBaseCell *)cell;

/**
 *	Displayed value that corresponds to each data source item
 *
 *	@param cell	A multi-value subclass of RTFormBaseCell (usually Segments or Picker)
 *
 *	@return Array of string values.
 */
- (NSArray< NSString* > *)titlesForMultiValueFormCell:(RTFormBaseCell *)cell;

@end





@protocol RTFormCellDelegate <NSObject>

@optional
/**
 *	Called when data value changes (text field, switch etc)
 *
 *	@param cell		Cell where change occured
 *	@param value	Latest value
 */
- (void)formCell:(RTFormBaseCell *)cell didChangeValue:(id)value;

/**
 *	Called when keyboard-related element (text field, text view) in the cell becomes first responder. Usual action is to slide it into view
 *
 *	@param cell	Activated cell.
 */
- (void)formCellDidActivate:(RTFormBaseCell *)cell;
/**
 *	Called when keyboard-related element (text field, text view) in the cell resigns being first responder. Usual action is to do nothing
 *
 *	@param cell	Deactivated cell.
 */
- (void)formCellDidDeactivate:(RTFormBaseCell *)cell;

/**
 *	Called when Return key is tapped on the keyboard for text-field cell. Or when UITextView editing is done
 *
 *	@param cell	Calling cell
 */
- (void)formCellDidFinish:(RTFormBaseCell *)cell;

@end



/**
 *	This is protocol that your Form VCs should adopt.
 *	Inherit this protocol if you need to add methods that handle specific behavior for your data source.
 *
 *	Object adopting this protocol becomes data source for the entire table view thus should create cells, headers, footers, whatever is needed (UITableViewDataSource)
 *	Lastly, it should handle data and state changes in the cells (RTFormCellDelegate)
 */

@protocol RTFormDataSource < UITableViewDataSource, RTFormCellDelegate >

@end
