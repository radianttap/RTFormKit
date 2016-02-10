//
//  RTFormController.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTFormDataSource;

@interface RTFormController : UIViewController

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong) __kindof RTFormDataSource *dataSource;

@end
