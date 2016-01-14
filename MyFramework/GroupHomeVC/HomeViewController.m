//
//  HomeViewController.m
//  MyFramework
//
//  Created by 满孝意 on 15/12/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#import "HomeViewController.h"
#import <QuickLook/QuickLook.h>
#import "AdsPagesViewController.h"
#import "RefreshViewController.h"

@interface HomeViewController () <QLPreviewControllerDataSource, QLPreviewControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"首页";
    
    self.dataArray = @[@"广告页", @"IQKeyboardManager", @"登录账号", @"刷新界面", @"下载文件"];
}

#pragma mark -
#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AdsPagesViewController *apvc = [[AdsPagesViewController alloc] init];
    apvc.hidesBottomBarWhenPushed = YES;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RefreshViewController *rfvc = [storyboard instantiateViewControllerWithIdentifier:@"RefreshViewController"];
    rfvc.hidesBottomBarWhenPushed = YES;
    
    switch (indexPath.section) {
        case 0: [self.navigationController pushViewController:apvc animated:YES]; break;
        case 1:   break;
        case 2: [self login];  break;
        case 3: [self.navigationController pushViewController:rfvc animated:YES];  break;
        case 4: [self downloadPDF];  break;
        default: break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 登录
- (void)login {
    [MYGlobalMethod userLogOff];
    [self postRequestInform];
}

// GET
- (void)getRequestInform {
    [MYGlobalMethod showLoadText:@"数据加载中..." view:self.view];
    
    // 登录 http://ip:port/corp/login?v=1&data={lname:'商家登录名',pw:'密码'}
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"18583875010" forKey:@"lname"];
    [dict setValue:@"123456" forKey:@"pw"];
    [MYHttpRequest requestGETWith:@"corp" and:@"login" dict:dict requestSuccess:^(id json) {
        NSDictionary *dict = json;
        
        if ([[dict objectForKey:@"status"] integerValue] == 0) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MYGlobalMethod userLogOnWithDict:dict[@"detail"]];
        } else {
            [MYGlobalMethod showText:dict[@"msg"] view:self.view completionBlock:nil];
        }
    } requestFailure:^(NSError *error) {
        [MYGlobalMethod showText:@"网络请求失败，请重试" view:self.view completionBlock:nil];
    }];
}

// POST
- (void)postRequestInform {
    [MYGlobalMethod showLoadText:@"数据加载中..." view:self.view];
    
    // 登录 http://ip:port/corp/login?v=1&data={lname:'商家登录名',pw:'密码'}
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"18583875010" forKey:@"lname"];
    [dict setValue:@"123456" forKey:@"pw"];
    [MYHttpRequest requestPOSTWith:@"corp" and:@"login" dict:dict requestSuccess:^(id json) {
        NSDictionary *dict = json;
        
        if ([[dict objectForKey:@"status"] integerValue] == 0) {
            [MYGlobalMethod showText:@"登录成功" view:self.view completionBlock:nil];
            [MYGlobalMethod userLogOnWithDict:dict[@"detail"]];
        } else {
            [MYGlobalMethod showText:dict[@"msg"] view:self.view completionBlock:nil];
        }
    } requestFailure:^(NSError *error) {
        [MYGlobalMethod showText:@"网络请求失败，请重试" view:self.view completionBlock:nil];
    }];
}

#pragma mark -
#pragma mark - download
- (void)downloadPDF {
    [MYGlobalMethod showLoadText:@"数据加载中..." view:self.view];
    
    [MYHttpRequest downloadFileWithWithFuncName:@"salary" function:@"exportsalarydata" jobid:nil success:^(id json) {
        [MYGlobalMethod showText:@"导出成功" view:self.view completionBlock:nil];
        
        NSString *FileName = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/工资单明细.xlsx"];
        [json writeToFile:FileName options:NSDataWritingAtomic error:nil];
        
        QLPreviewController *ql = [[QLPreviewController alloc] init];
        ql.delegate = self;
        ql.dataSource = self;
        [self presentViewController:ql animated:YES completion:nil];
        
    } failure:^(NSError *error) {
        [MYGlobalMethod showText:@"导出失败" view:self.view completionBlock:nil];
    }];
}

// QLPreviewController代理方法
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSString *FileName=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/工资单明细.xlsx"];
    NSLog(@"FileName = %@",FileName);
    return [NSURL fileURLWithPath:FileName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
