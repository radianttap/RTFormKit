//
//  RTFormHeader.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 11.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFormHeader : UITableViewHeaderFooterView

+ (NSString *)reuseIdentifier;
+ (UINib *)nib;
+ (instancetype)nibInstance;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end
