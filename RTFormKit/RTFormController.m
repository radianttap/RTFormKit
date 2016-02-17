//
//  RTFormController.m
//  RTFormKit
//
//  Created by Aleksandar Vacić on 10.2.16..
//  Copyright © 2016. Radiant Tap. All rights reserved.
//

#import "RTFormKit.h"

@interface RTFormController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RTFormController

- (instancetype)init {

	self = [super init];
	if (!self) return nil;

	_dateEditingIndexPath = nil;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:UIKeyboardWillHideNotification object:nil];

	return self;
}

- (void)dealloc {

	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleNotification:(NSNotification *)notification {

	if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
		CGRect endRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
		UIEdgeInsets insets = self.tableView.contentInset;
		insets.bottom = endRect.size.height;
		self.tableView.contentInset = insets;

	} else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
		UIEdgeInsets insets = self.tableView.contentInset;
		insets.bottom = 0;
		self.tableView.contentInset = insets;
	}
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

	if ([tv respondsToSelector:@selector(cellLayoutMarginsFollowReadableWidth)]) {
		tv.cellLayoutMarginsFollowReadableWidth = YES;
	}
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
	[self.tableView registerNib:[RTFormSegmentsCell nib] forCellReuseIdentifier:[RTFormSegmentsCell reuseIdentifier]];
	[self.tableView registerNib:[RTFormDateCell nib] forCellReuseIdentifier:[RTFormDateCell reuseIdentifier]];
	[self.tableView registerNib:[RTFormDateCell nib] forCellReuseIdentifier:[RTFormDateCell reuseIdentifierEditing]];

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

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	RTFormBaseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	switch (cell.cellType) {
		case RTFormCellTypeOneLineField: {
			RTFormOneLineFieldCell *tcell = (RTFormOneLineFieldCell *)cell;
			[tcell.textField becomeFirstResponder];
			break;
		}
		case RTFormCellTypeMultiLineField: {
			break;
		}
		default: {
			//	for all other cells, resign the first responder
			[tableView endEditing:YES];
			break;
		}
	}
}

#pragma mark - RTFormCellDelegate

- (void)formCell:(RTFormBaseCell *)cell didChangeValue:(id)value {

}

- (void)formCellDidActivate:(RTFormBaseCell *)cell {

	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	if ([cell isKindOfClass:[RTFormDateCell class]]) {
		//	is some other date cell active? close it up before activating new one
		if (self.dateEditingIndexPath) {
			self.dateEditingIndexPath = nil;
			[self.tableView reloadRowsAtIndexPaths:@[self.dateEditingIndexPath] withRowAnimation:UITableViewRowAnimationNone];
		}
		self.dateEditingIndexPath = indexPath;
		[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	} else {
		//	close-up the date cell if some other type of cell is activated
		if (self.dateEditingIndexPath) {
			self.dateEditingIndexPath = nil;
			[self.tableView reloadRowsAtIndexPaths:@[self.dateEditingIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		}
	}

	[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)formCellDidDeactivate:(RTFormBaseCell *)cell {

	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	if ([cell isKindOfClass:[RTFormDateCell class]]) {
		self.dateEditingIndexPath = nil;
		[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

- (void)formCellDidFinish:(RTFormBaseCell *)cell {

	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	if ([cell isKindOfClass:[RTFormDateCell class]]) {
		self.dateEditingIndexPath = nil;
		[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		return;
	}

	//	for textfield cell
	//	figure out should editing jump to next cell or simply resign keyboard
	[cell endEditing:YES];
}

#pragma mark - RTFormDataSource delegate calls


@end
