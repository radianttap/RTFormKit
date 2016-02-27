//
//  RTFormPickerCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 17.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormBaseCell.h"

@interface RTFormPickerCell : RTFormBaseCell

@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) UIButton *valueButton;
@property (nonatomic, weak, readonly) UIView *separator;

+ (NSString *)reuseIdentifierEditing;
@property (nonatomic, getter=isValueEditingEnabled) BOOL valueEditingEnabled;

@property (nonatomic, getter=shouldAutoCollapseAfterSelection) BOOL autoCollapseAfterSelection;

@end
