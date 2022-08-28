//
//  TemViewDataController.h
//  pro1
//
//  Created by ByteDance on 2022/8/26.
//

#import <Foundation/Foundation.h>

typedef void (^executeBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface WeatherReportDataController : NSObject

@property (nonatomic, strong) NSMutableArray *temArr;
@property (nonatomic, strong) NSMutableArray *weaImgArr;
@property (nonatomic, strong) NSString *currentTime;
@property (nonatomic, assign) NSInteger currentHour;
@property (nonatomic, strong) NSMutableArray *dayDataArr;

@property (nonatomic, strong) NSString *airLevel;
@property (nonatomic, strong) NSString *airTips;
@property (nonatomic, strong) NSString *airQua;

@property (nonatomic, strong) NSArray *pickerArr;
@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *weaDic;
@property (nonatomic, copy) NSString *currentCity;

@property (nonatomic, copy) NSString *winSpeedTip;
@property (nonatomic, copy) NSString *weaTip;

-(void)fetchDataWithCityID:(NSString*) cityid withblock:(executeBlock)block;

@end

NS_ASSUME_NONNULL_END
