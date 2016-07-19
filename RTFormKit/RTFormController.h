//
//  RTFormController.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

@import UIKit;
#import "RTFormDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *	Basic form controller. Should cover most cases that you need, subclass to customize
 */
@interface RTFormController : UIViewController < UITableViewDelegate, RTFormDataSource >

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, nullable) NSIndexPath *dateEditingIndexPath;
@property (nonatomic, strong, nullable) NSIndexPath *pickerEditingIndexPath;

@end

NS_ASSUME_NONNULL_END
