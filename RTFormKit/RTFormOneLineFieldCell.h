//
//  RTFormOneLineFieldCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormBaseCell.h"

@interface RTFormOneLineFieldCell : RTFormBaseCell

@property (nonatomic, weak, readonly) UITextField *textField;
@property (nonatomic, weak, readonly) UIView *separator;

@end
