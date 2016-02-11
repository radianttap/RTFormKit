//
//  RTRegisterCustomerController.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTRegisterCustomerController.h"
#import "RTFormKit.h"

@interface RTRegisterCustomerController ()

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
	v.titleLabel.text = self.sectionNames[section];
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
			[cell setupUsingConfiguration:config];
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

			break;
		}
		case RTFormCellTypeRange: {

			break;
		}
		case RTFormCellTypeMultiValuePicker: {

			break;
		}
		case RTFormCellTypeMultiValueSegments: {

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

}

#pragma mark - RTFormDataSource delegate calls



@end
