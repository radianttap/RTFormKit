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

	newcopy.title = self.title;
	newcopy.subtitle = self.subtitle;
	newcopy.hint = self.hint;
	newcopy.explanation = self.explanation;
	newcopy.placeholder = self.placeholder;

	newcopy.value = self.value;
	newcopy.defaultValue = self.defaultValue;

	newcopy.disabled = self.disabled;
	newcopy.mandatory = self.mandatory;

	return newcopy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

	[aCoder encodeObject:@(self.cellType) forKey:NSStringFromSelector(@selector(cellType))];
	[aCoder encodeObject:self.key forKey:NSStringFromSelector(@selector(key))];

	[aCoder encodeObject:self.title forKey:NSStringFromSelector(@selector(title))];
	[aCoder encodeObject:self.subtitle forKey:NSStringFromSelector(@selector(subtitle))];
	[aCoder encodeObject:self.hint forKey:NSStringFromSelector(@selector(hint))];
	[aCoder encodeObject:self.explanation forKey:NSStringFromSelector(@selector(explanation))];
	[aCoder encodeObject:self.placeholder forKey:NSStringFromSelector(@selector(placeholder))];

	[aCoder encodeObject:self.value forKey:NSStringFromSelector(@selector(value))];
	[aCoder encodeObject:self.defaultValue forKey:NSStringFromSelector(@selector(defaultValue))];

	[aCoder encodeObject:@(self.isDisabled) forKey:NSStringFromSelector(@selector(isDisabled))];
	[aCoder encodeObject:@(self.isMandatory) forKey:NSStringFromSelector(@selector(isMandatory))];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

	self = [super init];
	if (!self) return nil;

	_cellType = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(cellType))] integerValue];
	_key = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(key))];

	_title = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(title))];
	_subtitle = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(subtitle))];
	_hint = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(hint))];
	_explanation = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(explanation))];
	_placeholder = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(placeholder))];

	_value = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(value))];
	_defaultValue = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(defaultValue))];

	_disabled = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(isDisabled))];
	_mandatory = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(isMandatory))];

	return self;
}

@end
