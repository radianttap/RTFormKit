//
//  RTFormController.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormController () < UITableViewDelegate, RTFormDataSource >

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RTFormController

- (instancetype)init {

	self = [super init];
	if (!self) return nil;

	return self;
}

- (void)loadView {
	[super loadView];

	UITableView *tv = [UITableView new];
	tv.translatesAutoresizingMaskIntoConstraints = NO;
	tv.dataSource = self;
	tv.delegate = self;

	tv.rowHeight = UITableViewAutomaticDimension;
	tv.sectionHeaderHeight = UITableViewAutomaticDimension;
	tv.sectionFooterHeight = UITableViewAutomaticDimension;

	tv.estimatedRowHeight = 50;
	tv.estimatedSectionHeaderHeight = 44;
	tv.estimatedSectionFooterHeight = 0;

	tv.cellLayoutMarginsFollowReadableWidth = YES;
	tv.separatorColor = [UIColor formSeparatorColor];
	tv.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	[self.view addSubview:tv];
	self.tableView = tv;

	NSDictionary *vd = @{@"tv": tv};
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tv]|" options:0 metrics:nil views:vd]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tv]|" options:0 metrics:nil views:vd]];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor formBackgroundColor];
	self.tableView.backgroundColor = [UIColor formBackgroundColor];

	[self.tableView registerNib:[RTFormHeader nib] forHeaderFooterViewReuseIdentifier:[RTFormHeader reuseIdentifier]];
	[self.tableView registerNib:[RTFormInfoCell nib] forCellReuseIdentifier:[RTFormInfoCell reuseIdentifier]];
	[self.tableView registerNib:[RTFormOneLineFieldCell nib] forCellReuseIdentifier:[RTFormOneLineFieldCell reuseIdentifier]];
	[self.tableView registerNib:[RTFormToggleCell nib] forCellReuseIdentifier:[RTFormToggleCell reuseIdentifier]];

}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

#pragma mark - RTFormCellDelegate

- (void)formCell:(RTFormBaseCell *)cell didChangeValue:(id)value {

}

#pragma mark - RTFormDataSource delegate calls


@end
