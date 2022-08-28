//
//  TemModel.h
//  pro1
//
//  Created by ByteDance on 2022/8/26.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherReportModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *weaData;
@property (nonatomic, strong) NSString *updateTime;

@end

NS_ASSUME_NONNULL_END
