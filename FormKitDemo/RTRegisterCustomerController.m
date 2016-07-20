//
//  RTRegisterCustomerController.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTRegisterCustomerController.h"
#import "RTFormKit.h"

@interface RTRegisterCustomerController () < RTFormCellDataSource >

@property (nonatomic, copy) NSArray< RTFormDataGroup* > *dataSource;
@property (nonatomic, strong) NSDateFormatter *dobFormatter;

@end

@implementation RTRegisterCustomerController

- (instancetype)init {

	self = [super init];
	if (!self) return nil;

	NSDateFormatter *df = [NSDateFormatter new];
	df.dateStyle = NSDateFormatterMediumStyle;
	self.dobFormatter = df;

	[self createDataSource];

	return self;
}

- (void)createDataSource {

	NSMutableArray *groups = [NSMutableArray array];
	{
		//	section 1: Essentials
		NSMutableArray *marr = [NSMutableArray array];
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeInfo;
			row.key = @"essentialIntro";
			row.value = @"The following fields are all mandatory, please fill them in";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeOneLineField;
			row.key = @"email";
			row.value = @"";
			row.placeholder = @"Email address";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeOneLineField;
			row.key = @"password";
			row.value = @"";
			row.placeholder = @"password";
			row.hint = @"Minimum is 5 characters, no maximum.";
			row.explanation = @"Note: go wild here, don't use easy to figure out stuff, like dates of birth or names of family members. We recommend to use password generators, like 1Password or similar.";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeOneLineField;
			row.key = @"nickname";
			row.value = @"";
			row.placeholder = @"Nickname";
			row.explanation = @"This is the only bit of info everyone on Blerch will see.";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeMultiValueSegments;
			row.key = @"gender";
			row.value = @"Unknown";
			row.title = @"Gender";

			[marr addObject:row];
		}

		RTFormDataGroup *group = [RTFormDataGroup new];
		group.title = @"Essential Details";
		group.items = marr;
		[groups addObject:group];
	}

	{
		//	section 2: Email Notifications
		NSMutableArray *marr = [NSMutableArray array];
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeToggle;
			row.key = @"notifComments";
			row.value = @YES;
			row.title = @"New comments";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeToggle;
			row.key = @"notifFollowers";
			row.value = @NO;
			row.title = @"New followers";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeMultiValueSegments;
			row.key = @"notifPeriod";
			row.value = @7;
			row.title = @"Notification cycle";

			[marr addObject:row];
		}

		RTFormDataGroup *group = [RTFormDataGroup new];
		group.title = @"Email Notifications";
		group.items = marr;
		[groups addObject:group];
	}

	{
		//	section 3: Details
		NSMutableArray *marr = [NSMutableArray array];
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeDatePicker;
			row.key = @"dateOfBirth";
			row.title = @"Date of Birth";

			//	set default value to 18 years before now
			NSDateComponents *yearComps = [NSDateComponents new];
			yearComps.year = 18;
			NSDate *date = [NSCalendar.currentCalendar dateByAddingComponents:yearComps toDate:NSDate.date options:NSCalendarWrapComponents];
			row.defaultValue = date;

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeMultiValuePicker;
			row.key = @"country";
			row.defaultValue = @"RS";
			row.title = @"Country";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeOneLineField;
			row.key = @"street";
			row.value = @"";
			row.placeholder = @"Street name and number";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeOneLineField;
			row.key = @"street2";
			row.value = @"";
			row.placeholder = @"Building, Apt";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeOneLineField;
			row.key = @"zipcode";
			row.value = @"";
			row.placeholder = @"Zip code";

			[marr addObject:row];
		}
		{
			RTFormDataItem *row = [RTFormDataItem new];
			row.cellType = RTFormCellTypeOneLineField;
			row.key = @"City";
			row.value = @"";
			row.placeholder = @"City";

			[marr addObject:row];
		}

		RTFormDataGroup *group = [RTFormDataGroup new];
		group.title = @"Personal Details";
		group.items = marr;
		[groups addObject:group];
	}

	self.dataSource = groups;
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

	RTFormDataGroup *group = self.dataSource[section];

	RTFormHeader *v = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[RTFormHeader reuseIdentifier]];
	v.titleLabel.text = [group.title uppercaseString];
	return v;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	RTFormDataGroup *group = self.dataSource[section];
	return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	RTFormDataGroup *group = self.dataSource[indexPath.section];
	RTFormDataItem *config = group.items[indexPath.item];

	switch (config.cellType) {
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

			//	defaults
			//	anything you potentially override below in custom setup, you need to first reset to default here
			//	otherwise cell reuse may give nasty surprises
			cell.textField.keyboardType = UIKeyboardTypeDefault;
			cell.textField.secureTextEntry = NO;

			//	custom setup
			NSString *dataKey = config.key;
			if ([dataKey isEqualToString:@"email"]) {
				cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
			} else if ([dataKey isEqualToString:@"password"]) {
				cell.textField.secureTextEntry = YES;
			}

			//	alternating background color
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
			BOOL isValueEditing = [indexPath isEqual:self.pickerEditingIndexPath];
			RTFormPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:(isValueEditing) ? [RTFormPickerCell reuseIdentifierEditing] : [RTFormPickerCell reuseIdentifier]
																	 forIndexPath:indexPath];
			cell.valueEditingEnabled = isValueEditing;
			cell.delegate = self;
			cell.dataSource = self;
			[cell setupUsingConfiguration:config];

			cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor formBackgroundColor] : [UIColor formBackgroundAlternateColor];
			return cell;
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
		case RTFormCellTypeDatePicker: {
			BOOL isDateEditing = [indexPath isEqual:self.dateEditingIndexPath];
			RTFormDateCell *cell = [tableView dequeueReusableCellWithIdentifier:(isDateEditing) ? [RTFormDateCell reuseIdentifierEditing] : [RTFormDateCell reuseIdentifier]
																   forIndexPath:indexPath];
			cell.dateEditingEnabled = isDateEditing;
			cell.dateFormatter = self.dobFormatter;
			cell.delegate = self;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];

}




#pragma mark - RTFormCellDelegate

- (void)formCell:(RTFormBaseCell *)cell didChangeValue:(id)value {
	[super formCell:cell didChangeValue:value];

	NSLog(@"%@ == %@", cell.key, value);

	//	udpate value in data source
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	if (!indexPath) {
		//	hm...
	}
	RTFormDataGroup *group = self.dataSource[indexPath.section];
	RTFormDataItem *config = group.items[indexPath.item];
	config.value = value;
}

- (void)formCellDidFinish:(RTFormBaseCell *)cell {
	[super formCellDidFinish:cell];

	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	if (!indexPath) {
		//	hm...
	}
	RTFormDataGroup *group = self.dataSource[indexPath.section];
	NSArray< RTFormDataItem* > *rows = group.items;

	//	now figure out should editing jump to next cell or simply resign keyboard
	//	check only inside the current section
	//	look for next text field and if found, auto-activate it
	BOOL shouldResign = YES;
	for (NSInteger r = indexPath.row+1; r < rows.count; r++) {
		RTFormDataItem *config = rows[r];
		BOOL shouldBreak = NO;
		switch ( config.cellType ) {
			case RTFormCellTypeOneLineField: {
				NSIndexPath *rowIndexPath = [NSIndexPath indexPathForRow:r inSection:indexPath.section];
				RTFormOneLineFieldCell *cell = [self.tableView cellForRowAtIndexPath:rowIndexPath];
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

	} else if ([cell.key isEqualToString:@"gender"]) {
		return @[@"Male", @"Female", @"Unknown"];

	} else if ([cell.key isEqualToString:@"country"]) {
		//	get	all country codes from iOS
		return [NSLocale ISOCountryCodes];
	}

	return nil;
}

- (NSArray *)titlesForMultiValueFormCell:(RTFormBaseCell *)cell {

	if ([cell.key isEqualToString:@"notifPeriod"]) {
		return @[@"Daily", @"Weekly", @"Bi-weekly", @"Monthly"];

	} else if ([cell.key isEqualToString:@"gender"]) {
		return @[@"Male", @"Female", @"/won't say/"];

	} else if ([cell.key isEqualToString:@"country"]) {
		//	figure out all the country names
		NSMutableArray *marr = [NSMutableArray array];
		[[NSLocale ISOCountryCodes] enumerateObjectsUsingBlock:^(NSString * _Nonnull countryCode, NSUInteger idx, BOOL * _Nonnull stop) {
			NSString *name = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
			[marr addObject:name];
		}];
		return marr;
	}

	return nil;
}

#pragma mark - RTFormDataSource delegate calls



@end
