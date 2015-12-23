//
//  FindViewController.m
//  MyFramework
//
//  Created by 满孝意 on 15/12/21.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#import "FindViewController.h"
#import "MYHeaderFile.h"
#import "QRCodeViewController.h"

@interface FindViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"发现";
    
    self.dataArray = @[@"二维码", @"AlertView/ActionSheet", @" "];
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
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: [self scanQRCodeView]; break;
        case 1: [self showAlertView]; break;
        case 2: [self scanQRCodeView]; break;
        case 3: [self scanQRCodeView]; break;
        default: break;
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark - 方法实现
- (void)showAlertView {
//    [MYAlertAction showActionSheetWithTitle:@"hhh" message:nil chooseBlock:^(NSInteger buttonIdx) {
//        NSLog(@"%ld", buttonIdx);
//    } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitle:@"111", @"222", nil];
    
//    [MYAlertAction showAlertWithTitle:@"hhh" msg:@"ceshi" chooseBlock:^(NSInteger buttonIdx) {
//        NSLog(@"%ld", buttonIdx);
//    } buttonsStatement:@"取消", @"确定", nil];
    
    
    [MYGlobalMethod alertView:@"dfdsfdsa"];
}

- (void)scanQRCodeView {
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QRCodeViewController *qrvc = [storyboard instantiateViewControllerWithIdentifier:@"QRCodeViewController"];
    qrvc.style = style;
    qrvc.isQQSimulator = YES;
    [self.navigationController pushViewController:qrvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
