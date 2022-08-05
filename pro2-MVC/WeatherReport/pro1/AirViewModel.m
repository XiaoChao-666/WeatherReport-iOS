//
//  AirViewModel.m
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import "AirViewModel.h"
#import <AFNetworking.h>

@implementation AirViewModel

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


@end
