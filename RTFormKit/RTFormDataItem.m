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

- (instancetype)copyWithZone:(NSZone *)zone {

	RTFormDataItem *newcopy = [[RTFormDataItem allocWithZone:zone] init];
	newcopy.cellType = self.cellType;
	newcopy.key = self.key;

	return newcopy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

	[aCoder encodeObject:@(self.cellType) forKey:NSStringFromSelector(@selector(cellType))];
	[aCoder encodeObject:self.key forKey:NSStringFromSelector(@selector(key))];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

	self = [super init];
	if (!self) return nil;

	_cellType = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(cellType))] integerValue];
	_key = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(key))];

	return self;
}

@end
