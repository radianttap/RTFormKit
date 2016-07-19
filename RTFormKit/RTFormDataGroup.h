//
//  RTFormDataGroup.h
//  RTFormKit
//
//  Created by Aleksandar Vacić on 19.7.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RTFormDataItem;

@interface RTFormDataGroup : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray< RTFormDataItem* > *items;

@end
