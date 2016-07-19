//
//  RTFormDataGroup.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 19.7.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormDataGroup.h"
#import "RTFormDataItem.h"

@implementation RTFormDataGroup

- (instancetype)init {

	self = [super init];
	if ( !self ) return nil;

	_title = @"";
	_items = @[];

	return self;
}

@end
