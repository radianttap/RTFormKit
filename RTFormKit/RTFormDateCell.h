//
//  RTFormDateCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 13.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormBaseCell.h"

@interface RTFormDateCell : RTFormBaseCell

@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) UIButton *dateButton;
@property (nonatomic, weak, readonly) UIDatePicker *datePicker;
@property (nonatomic, weak, readonly) UIView *separator;

@property (nonatomic) NSDateFormatter *dateFormatter;

+ (NSString *)reuseIdentifierEditing;
@property (nonatomic, getter=isDateEditingEnabled) BOOL dateEditingEnabled;

@end
