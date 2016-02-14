//
//  RTFormController.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTFormController : UIViewController

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, nullable, readonly) NSIndexPath *dateEditingIndexPath;

@end

NS_ASSUME_NONNULL_END