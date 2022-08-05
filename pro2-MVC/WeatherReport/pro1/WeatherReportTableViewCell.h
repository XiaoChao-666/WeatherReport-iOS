//
//  tableView1Cell.h
//  pro1
//
//  Created by ByteDance on 2022/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherReportTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *labelDate;
@property (strong, nonatomic) UILabel *labelMaxTem;
@property (strong, nonatomic) UILabel *labelMinTem;
@property (strong, nonatomic) UIImageView *WeatherImageView;

@end

NS_ASSUME_NONNULL_END
