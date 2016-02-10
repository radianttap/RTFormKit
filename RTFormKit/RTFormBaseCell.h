//
//  RTFormBaseCell.h
//  FormKitDemo
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFormBaseCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (UINib *)nib;
+ (instancetype)nibInstance;

@end
