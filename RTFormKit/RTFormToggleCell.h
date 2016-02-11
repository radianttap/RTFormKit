//
//  RTFormToggleCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormBaseCell.h"

@interface RTFormToggleCell : RTFormBaseCell

@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) UISwitch *toggleSwitch;

@end
