//
//  CollectionView1Cell.h
//  pro1
//
//  Created by ByteDance on 2022/8/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherReportCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *labelDate;
@property (strong, nonatomic) UILabel *weatherLabel;
@property (strong, nonatomic) UIImageView *weatherImageView;

@end

NS_ASSUME_NONNULL_END
