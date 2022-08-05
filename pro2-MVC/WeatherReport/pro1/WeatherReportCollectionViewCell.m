//
//  CollectionView1Cell.m
//  pro1
//
//  Created by ByteDance on 2022/8/1.
//

#import "WeatherReportCollectionViewCell.h"
#import <Masonry.h>


@implementation WeatherReportCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 20, 20)];
        self.labelDate = [[UILabel alloc] init];
        self.labelDate.textAlignment = NSTextAlignmentCenter;
        self.labelDate.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.labelDate];
        [self.labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.centerX.equalTo(self);
        }];
        
        //self.weatherImageView = [[UIImageView alloc] initWithFrame: CGRectMake(12, 70, 20, 20)];
        self.weatherImageView = [[UIImageView alloc] init];
        [self addSubview:self.weatherImageView];
        [self.weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];

        //self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 40, 20)];
        self.weatherLabel = [[UILabel alloc] init];
        self.weatherLabel.textAlignment = NSTextAlignmentCenter;
        self.weatherLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.weatherLabel];
        [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-10);
            make.centerX.equalTo(self);
        }];


    }
    return self;
}


@end
