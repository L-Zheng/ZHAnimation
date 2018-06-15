//
//  ViewController.m
//  ZHAnimation
//
//  Created by 李保征 on 2018/2/27.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "ViewController.h"
#import "ZHMarqueeVC.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,retain) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"animation";
    
    //    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (systemVersion >= 11.0) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat tableViewY = 64;
        CGFloat tableViewH = self.view.bounds.size.height - tableViewY;
        CGFloat tableViewX = 0;
        CGFloat tableViewW = self.view.bounds.size.width;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        
        //控制器遵守代理
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //        _<#tableViewName#>.separatorInset = UIEdgeInsetsZero;
        //        _<#tableViewName#>.separatorColor = [UIColor blackColor];
        
        //去除没有数据时显示分割线bug
        _tableView.tableFooterView = [[UIView alloc] init];
        
        _tableView.allowsSelectionDuringEditing = YES;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        NSArray *data = @[
                          @{
                              @"title" : @"文字跑马灯",
                              @"action" : @"textMarqueeView"
                              }
                          ];
        _dataArray = [NSMutableArray arrayWithArray:data];
    }
    return _dataArray;
}

#pragma mark - action

- (void)textMarqueeView{
    ZHMarqueeVC *vc = [[ZHMarqueeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.dataArray[indexPath.row] valueForKey:@"title"];
    return cell;
}

//选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectorStr = [self.dataArray[indexPath.row] valueForKey:@"action"];
    
    if (selectorStr.length > 0) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(selectorStr)];
#pragma clang diagnostic push
    }
}




@end
