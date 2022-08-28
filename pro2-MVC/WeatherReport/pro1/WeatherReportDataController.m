//
//  TemViewDataController.m
//  pro1
//
//  Created by ByteDance on 2022/8/26.
//

#import <AFNetworking.h>
#import <YYKit.h>
#import "WeatherReportDataController.h"
#import "WeatherReportModel.h"


@implementation WeatherReportDataController

- (instancetype)init {
    self = [super init];
    
    self.temArr = [[NSMutableArray alloc] init];
    self.weaImgArr = [[NSMutableArray alloc] init];
    self.dayDataArr = [[NSMutableArray alloc] init];
    
    self.currentCity = @"北京";
    NSArray *objArray = @[@"成都",@"北京",@"上海"];
    NSArray *keyArray = @[@"101270101",@"101010100",@"101020200"];
    self.cityDic = [NSDictionary dictionaryWithObjects:keyArray forKeys:objArray];
    
    NSArray *objArray2 = @[@"qing",@"yun",@"yin",@"xue",@"yu"];
    NSArray *keyArray2 = @[@"晴",@"云",@"阴",@"雪",@"雨"];
    self.weaDic = [NSDictionary dictionaryWithObjects:keyArray2 forKeys:objArray2];
    
    self.pickerArr = [[NSArray alloc]initWithObjects:@"北京",@"上海",@"成都", nil];
    
    return self;
}

-(void)fetchDataWithCityID:(NSString*) cityid withblock:(executeBlock)block {
    NSString *urlString = [NSString stringWithFormat:@"https://yiketianqi.com/api?unescape=1&version=v1&appid=59632127&appsecret=78bXzRL3&cityid=%@",cityid];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    @weakify(self);
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSError *error = nil;
        WeatherReportModel *model =  [MTLJSONAdapter modelOfClass:WeatherReportModel.class  fromJSONDictionary:dataDic error:&error];
        [self p_dealWithModel:model];
        NSLog(@"success");
        block();
     }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
              NSLog(@"%@",error);
     }];
}

-(void)p_dealWithModel:(WeatherReportModel *)model {
    [self.dayDataArr removeAllObjects];
    [self.weaImgArr removeAllObjects];
    [self.temArr removeAllObjects];
    NSMutableArray *temTempArr = [[NSMutableArray alloc] init];
    NSMutableArray *weaImgTempArr = [[NSMutableArray alloc] init];
    for(NSDictionary *obj in model.weaData) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        [tempDic setObject:[obj objectForKey:@"day"] forKey:@"day"];
        [tempDic setObject:[obj objectForKey:@"hours"] forKey:@"hours"];
        [tempDic setObject:[obj objectForKey:@"wea_img"] forKey:@"wea_img"];
        [self.dayDataArr addObject:tempDic];
        for(NSDictionary *obj2 in [obj objectForKey:@"hours"]) {
            [temTempArr addObject:[obj2 objectForKey:@"tem"]];
            [weaImgTempArr addObject:[obj2 objectForKey:@"wea_img"]];
            
        }
    }
    [self.temArr addObjectsFromArray:temTempArr];
    [self.weaImgArr addObjectsFromArray:weaImgTempArr];
    
    
    NSArray  *temp = [model.updateTime componentsSeparatedByString:@" "];
    NSArray  *temp2 = [temp[1] componentsSeparatedByString:@":"];
    self.currentHour = [temp2[0] intValue];
    self.currentTime = model.updateTime;
    
    self.airQua = [[model.weaData objectAtIndex:0] objectForKey:@"air"];
    self.airTips = [[model.weaData objectAtIndex:0] objectForKey:@"air_tips"];
    self.airLevel = [[model.weaData objectAtIndex:0] objectForKey:@"air_level"];
    
    self.winSpeedTip = [[model.weaData objectAtIndex:0] objectForKey:@"win_speed"];
    self.weaTip = [[model.weaData objectAtIndex:0] objectForKey:@"wea"];
}

@end
