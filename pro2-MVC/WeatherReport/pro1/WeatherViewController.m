//
//  ViewController.m
//  pro1
//
//  Created by ByteDance on 2022/6/22.
//

#import "WeatherViewController.h"
#import "TemViewController.h"
#import "AirViewController.h"


//@interface WeatherViewController ()
//{
//
//}
//
//
//@end



@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TemViewController *oneVc = [[TemViewController alloc]init];
    AirViewController *twoVc = [[AirViewController alloc]init];

    //设置控制器图片(使用imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal,不被系统渲染成蓝色)

    oneVc.tabBarItem.image = [[UIImage imageNamed:@"1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //oneVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    twoVc.tabBarItem.image = [[UIImage imageNamed:@"2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //twoVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //改变tabbarController 文字选中颜色(默认渲染为蓝色)
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];

    //创建一个数组包含四个导航栏控制器
    NSArray *vcArry = [NSArray arrayWithObjects:oneVc,twoVc,nil];

    //将数组传给UITabBarController
    self.viewControllers = vcArry;

}







@end
