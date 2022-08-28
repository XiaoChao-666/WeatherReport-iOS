//
//  TemModel.m
//  pro1
//
//  Created by ByteDance on 2022/8/26.
//

#import "WeatherReportModel.h"

@implementation WeatherReportModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"weaData": @"data",
           @"updateTime": @"update_time"
  };
}

@end
