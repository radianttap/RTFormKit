//
//  RTFormDataSource.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

@import UIKit;

@protocol RTFormDataSourceDelegate;
@interface RTFormDataSource : NSObject < UITableViewDataSource >

@property (nonatomic, weak) id< RTFormDataSourceDelegate > delegate;

@end


/**
 *	Usually, data-source's delegate should be RTFormController, but it can be anything
 *	Add methods here that handle specific behavior for your data source, like post-form-submit that should switch controllers, push/pop controllers etc
 */
@protocol RTFormDataSourceDelegate <NSObject>

@optional

@end