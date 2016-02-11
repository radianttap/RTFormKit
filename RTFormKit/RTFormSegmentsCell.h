//
//  RTFormSegmentsCell.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormBaseCell.h"

@interface RTFormSegmentsCell : RTFormBaseCell

@property (nonatomic, weak, readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) UISegmentedControl *segmentedControl;
@property (nonatomic, weak, readonly) UIView *separator;

@end
