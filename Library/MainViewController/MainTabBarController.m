//
//  MainTabBarController.m
//  MyFramework
//
//  Created by 满孝意 on 15/12/22.
//  Copyright © 2015年 满孝意. All rights reserved.
//

#import "MainTabBarController.h"
#import "MYHeaderFile.h"

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // UITabBarItem图片
    UITabBarItem *aTabBarItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *bTabBarItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *cTabBarItem = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *dTabBarItem = [self.tabBar.items objectAtIndex:3];
    aTabBarItem.selectedImage = [[UIImage imageNamed:@"home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    bTabBarItem.selectedImage = [[UIImage imageNamed:@"near_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cTabBarItem.selectedImage = [[UIImage imageNamed:@"find_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dTabBarItem.selectedImage = [[UIImage imageNamed:@"my_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // UITabBarItem字体颜色
    [self.tabBar setSelectedImageTintColor:RGBACOLOR(34, 161, 85, 1)];
    
    // UITabBar背景色
    self.tabBar.barTintColor = [MYGlobalMethod colorWithHexString:@"#ffffff" alpha:1.0];
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
