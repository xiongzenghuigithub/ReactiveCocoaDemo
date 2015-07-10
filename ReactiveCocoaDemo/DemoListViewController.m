//
//  DemoListViewController.m
//  ReactiveCocoaDemo
//
//  Created by XiongZenghui on 15/6/23.
//  Copyright (c) 2015年 XiongZenghui. All rights reserved.
//

#import "DemoListViewController.h"

#import "BasicViewController.h"

static NSString *Id = @"demoCell";

@implementation DemoListViewController {
    NSArray *_demos;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self setupArray];
    }
    return self;
}

- (void)setupArray {
    _demos = [NSArray arrayWithObjects:@"基础用法",@"",@"",@"", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_demos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    cell.detailTextLabel.text = _demos[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = [indexPath row];
    
    switch (row) {
        case 0: {
            BasicViewController *vc = [[BasicViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
