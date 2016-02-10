//
//  RTFormBaseCell.h
//  FormKitDemo
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFormBaseCell : UITableViewCell

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
+ (instancetype)nibInstance;

@end
