//
//  RTFormDataItem.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 19.7.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormDataItem.h"

@implementation RTFormDataItem

- (instancetype)init {

	self = [super init];
	if ( !self ) return nil;

	_cellType = RTFormCellTypeUnknown;
	_key = nil;

	_title = nil;
	_subtitle = nil;
	_hint = nil;
	_explanation = nil;
	_placeholder = nil;

	_value = nil;
	_defaultValue = nil;

	_mandatory = NO;
	_disabled = NO;

	return self;
}

@end
