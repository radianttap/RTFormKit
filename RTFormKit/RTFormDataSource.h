//
//  RTFormDataSource.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

@import UIKit;

/**
 *	Add methods here that handle specific behavior for your data source, 
 *	like post-form-submit that should switch controllers, push/pop various controllers etc.
 *
 *	This object is also a data source for the table view, so should create cells, headers, footers, whatever is needed (UITableViewDataSource)
 *
 *	Lastly, it should handle data changes in the cells (RTFormCellDelegate)
 */
@protocol RTFormCellDelegate;
@protocol RTFormDataSource < UITableViewDataSource, RTFormCellDelegate >

@end
