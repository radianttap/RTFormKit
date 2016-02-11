//
//  RTRegisterCustomerController.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTRegisterCustomerController.h"
#import "RTFormKit.h"

@interface RTRegisterCustomerController () < RTFormDataSource, RTFormCellDataSource >

@property (nonatomic, copy) NSDictionary *dataSource;
@property (nonatomic, copy) NSArray< NSString* > *sectionNames;

@end

@implementation RTRegisterCustomerController

- (instancetype)init {

	self = [super init];
	if (!self) return nil;

	[self createDataSource];

	return self;
}

- (void)createDataSource {

	NSMutableDictionary *md = [NSMutableDictionary dictionary];

	{
		//	section 1: Essentials
		NSMutableArray *marr = [NSMutableArray array];
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			row[@(RTFormConfigCellType)] = @(RTFormCellTypeInfo);
			row[@(RTFormConfigKey)] = @"essentialIntro";
			row[@(RTFormConfigValue)] = @"The following 5 fields are all mandatory, please fill them in";

			[marr addObject:row];
		}
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			row[@(RTFormConfigCellType)] = @(RTFormCellTypeOneLineField);
			row[@(RTFormConfigKey)] = @"email";
			row[@(RTFormConfigValue)] = @"";
			row[@(RTFormConfigPlaceholder)] = @"Email address";

			[marr addObject:row];
		}
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			row[@(RTFormConfigCellType)] = @(RTFormCellTypeOneLineField);
			row[@(RTFormConfigKey)] = @"password";
			row[@(RTFormConfigValue)] = @"";
			row[@(RTFormConfigPlaceholder)] = @"password";
			row[@(RTFormConfigHint)] = @"Minimum is 5 characters, no maximum.";
			row[@(RTFormConfigExplanation)] = @"Note: go wild here, don't use easy to figure out stuff, like dates of birth or names of family members. We recommend to use password generators, like 1Password or similar.";

			[marr addObject:row];
		}
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			row[@(RTFormConfigCellType)] = @(RTFormCellTypeOneLineField);
			row[@(RTFormConfigKey)] = @"nickname";
			row[@(RTFormConfigValue)] = @"";
			row[@(RTFormConfigPlaceholder)] = @"Nickname";
			row[@(RTFormConfigExplanation)] = @"This is the only bit of info everyone on Blerch will see.";

			[marr addObject:row];
		}
		md[@"Essential"] = marr;	//	dict key is the section name, to be shown as header
	}

	{
		//	section 2: Email Notifications
		NSMutableArray *marr = [NSMutableArray array];
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			row[@(RTFormConfigCellType)] = @(RTFormCellTypeToggle);
			row[@(RTFormConfigKey)] = @"notifComments";
			row[@(RTFormConfigValue)] = @YES;
			row[@(RTFormConfigTitle)] = @"New comments";

			[marr addObject:row];
		}
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			row[@(RTFormConfigCellType)] = @(RTFormCellTypeToggle);
			row[@(RTFormConfigKey)] = @"notifFollowers";
			row[@(RTFormConfigValue)] = @NO;
			row[@(RTFormConfigTitle)] = @"New followers";

			[marr addObject:row];
		}
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			row[@(RTFormConfigCellType)] = @(RTFormCellTypeMultiValueSegments);
			row[@(RTFormConfigKey)] = @"notifPeriod";
			row[@(RTFormConfigValue)] = @7;
			row[@(RTFormConfigTitle)] = @"Notification cycle";

			[marr addObject:row];
		}
		md[@"Email Notifications"] = marr;	//	dict key is the section name, to be shown as header
	}

	self.dataSource = md;
	self.sectionNames = [self.dataSource allKeys];
}




#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Join Blerch";

	//	custom setup
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}




#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.dataSource.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

	RTFormHeader *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[RTFormHeader reuseIdentifier]];
	v.titleLabel.text = [self.sectionNames[section] uppercaseString];
	return v;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	NSString *sectionKey = self.sectionNames[section];
	NSArray *rows = self.dataSource[sectionKey];
	return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *sectionKey = self.sectionNames[indexPath.section];
	NSArray *rows = self.dataSource[sectionKey];
	NSDictionary *config = rows[indexPath.row];

	switch ((RTFormCellType)[(NSNumber *)config[@(RTFormConfigCellType)] integerValue]) {
		case RTFormCellTypeInfo: {
			RTFormInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[RTFormInfoCell reuseIdentifier] forIndexPath:indexPath];
			[cell setupUsingConfiguration:config];

			cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor formBackgroundColor] : [UIColor formBackgroundAlternateColor];
			return cell;
			break;
		}
		case RTFormCellTypeOneLineField: {
			RTFormOneLineFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[RTFormOneLineFieldCell reuseIdentifier] forIndexPath:indexPath];
			cell.delegate = self;
			[cell setupUsingConfiguration:config];
			//	custom setup
			NSString *dataKey = config[@(RTFormConfigKey)];
			if ([dataKey isEqualToString:@"email"]) {
				cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
			} else if ([dataKey isEqualToString:@"password"]) {
				cell.textField.secureTextEntry = YES;
			}

			cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor formBackgroundColor] : [UIColor formBackgroundAlternateColor];
			return cell;
			break;
		}
		case RTFormCellTypeToggle: {
			RTFormToggleCell *cell = [tableView dequeueReusableCellWithIdentifier:[RTFormToggleCell reuseIdentifier] forIndexPath:indexPath];
			cell.delegate = self;
			[cell setupUsingConfiguration:config];

			cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor formBackgroundColor] : [UIColor formBackgroundAlternateColor];
			return cell;
			break;
		}
		case RTFormCellTypeRange: {

			break;
		}
		case RTFormCellTypeMultiValuePicker: {

			break;
		}
		case RTFormCellTypeMultiValueSegments: {
			RTFormSegmentsCell *cell = [tableView dequeueReusableCellWithIdentifier:[RTFormSegmentsCell reuseIdentifier] forIndexPath:indexPath];
			cell.delegate = self;
			cell.dataSource = self;
			[cell setupUsingConfiguration:config];

			cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor formBackgroundColor] : [UIColor formBackgroundAlternateColor];
			return cell;
			break;
		}
		default: {
			break;
		}
	}

	return nil;
}

#pragma mark - RTFormCellDelegate

- (void)formCell:(RTFormBaseCell *)cell didChangeValue:(id)value {

	NSLog(@"%@ == %@", cell.key, value);
}

- (void)formCellDidFinish:(RTFormBaseCell *)cell {

	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

	NSString *sectionKey = self.sectionNames[indexPath.section];
	NSArray *rows = self.dataSource[sectionKey];

	//	now figure out should editing jump to next cell or simply resign keyboard
	//	check only inside the current section
	//	look for next text field and if found, auto-activate it
	BOOL shouldResign = YES;
	for (NSInteger r = indexPath.row+1; r < rows.count; r++) {
		NSDictionary *config = rows[r];
		BOOL shouldBreak = NO;
		switch ((RTFormCellType)[(NSNumber *)config[@(RTFormConfigCellType)] integerValue]) {
			case RTFormCellTypeOneLineField: {
				RTFormOneLineFieldCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:indexPath.section]];
				[cell.textField becomeFirstResponder];
				shouldBreak = YES;
				shouldResign = NO;
				break;
			}
			default: {
				break;
			}
		}
		if (shouldBreak) break;
	}

	if (shouldResign) [cell endEditing:YES];
}


#pragma mark - RTFormCellDataSource

- (NSArray *)valuesForMultiValueFormCell:(RTFormBaseCell *)cell {

	if ([cell.key isEqualToString:@"notifPeriod"]) {
		return @[@1, @7, @14, @30];
	}

	return nil;
}

- (NSArray *)titlesForMultiValueFormCell:(RTFormBaseCell *)cell {

	if ([cell.key isEqualToString:@"notifPeriod"]) {
		return @[@"Daily", @"Weekly", @"Bi-weekly", @"Monthly"];
	}

	return nil;
}

#pragma mark - RTFormDataSource delegate calls



@end
