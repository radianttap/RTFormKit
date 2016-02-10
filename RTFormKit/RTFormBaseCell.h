//
//  RTFormBaseCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RTFormCellType) {
	RTFormCellTypeUnknown,
	RTFormCellTypeLabel,
	RTFormCellTypeTextField,
	RTFormCellTypeToggleSwitch,
	RTFormCellTypeMultiValue,
	RTFormCellTypeSlider,
};

@protocol RTFormCellDelegate;
@interface RTFormBaseCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (UINib *)nib;
+ (instancetype)nibInstance;

@property (nonatomic, weak) id< RTFormCellDelegate > delegate;
@property (nonatomic) RTFormCellType cellType;
@property (nonatomic, copy) NSString *key;
@property (nonatomic) BOOL enabled;

- (void)setup:(NSDictionary *)config;
- (void)applyTheme:(NSNotification *)notification;

@end



@protocol RTFormCellDelegate <NSObject>

@optional
- (void)formCell:(RTFormBaseCell *)cell didChangeValue:(id)value;

@end

NS_ASSUME_NONNULL_END