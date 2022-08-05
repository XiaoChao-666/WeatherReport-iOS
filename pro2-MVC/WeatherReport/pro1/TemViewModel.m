//
//  TemViewModel.m
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import "TemViewModel.h"
#import <AFNetworking.h>



@implementation TemViewModel

+(void)fetchDataWithCityID:(NSString*) cityid withblock:(void(^)(NSDictionary *))block{
    NSString *urlString = [NSString stringWithFormat:@"https://yiketianqi.com/api?unescape=1&version=v1&appid=59632127&appsecret=78bXzRL3&cityid=%@",cityid];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"请求成功的数据转换为字典 === %@",dataDic);
        NSLog(@"success");
        block(dataDic);
     }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
              NSLog(@"%@",error);
     }];
}

+ (NSString *)getCurrentDate {
    NSDate *currentDate = [NSDate date]; // 获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SS"]; // 设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate]; // 将时间转化成字符串
    return dateString;

}

@end
