//
//  AirViewModel.h
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AirViewModel : NSObject

+(void)fetchDataWithCityID:(NSString*) cityid withblock:(void(^)(NSDictionary *))block;

@end

NS_ASSUME_NONNULL_END
