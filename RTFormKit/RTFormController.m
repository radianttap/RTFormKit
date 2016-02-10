//
//  RTFormController.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormController () < UITableViewDelegate >

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
	tv.dataSource = self.dataSource;
	tv.delegate = self;
	tv.rowHeight = UITableViewAutomaticDimension;
	tv.estimatedRowHeight = 50;
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
}

#pragma mark - RTFormDataSource delegate calls?


@end
