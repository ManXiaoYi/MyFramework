//
//  RefreshViewController.m
//  MyFramework
//
//  Created by 满孝意 on 16/1/14.
//  Copyright © 2016年 满孝意. All rights reserved.
//

#import "RefreshViewController.h"

@interface RefreshViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, assign) NSInteger page;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //    [MYGlobalMethod showLoadText:@"数据请求中..." view:self.view];
    //__block SecondViewController *weakSelf = self;
    __block __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf postRequestInform];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf postRequestInform];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark -
#pragma mark - 获取数据
- (void)postRequestInform {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"4" forKey:@"size"];
    [dict setValue:[NSString stringWithFormat:@"%ld", self.page] forKey:@"page"];
    [MYHttpRequest requestPOSTWith:@"job" and:@"listbelow" dict:dict requestSuccess:^(id json) {
        if (self.page == 1) {
            self.dataArray = [[NSMutableArray alloc] initWithArray:json[@"jobs"]];
        } else {
            [self.dataArray addObjectsFromArray:json[@"jobs"]];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } requestFailure:^(NSError *error) {
        [MYGlobalMethod showText:@"网络请求超时,请稍后重试" view:self.view completionBlock:nil];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -
#pragma mark - UITableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
