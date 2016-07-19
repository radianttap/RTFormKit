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

@class RTFormDataItem;

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
- (void)setupUsingConfiguration:(RTFormDataItem *)config;
- (void)applyTheme:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
