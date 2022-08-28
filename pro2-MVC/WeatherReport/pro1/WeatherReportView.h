//
//  WeatherReportView.h
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WeatherReportBtn <NSObject>

@required
-(void) changeCityClickBtn:(id)sender;
-(void) pickDoneClickBtn:(id)sender;
-(void) pickCancelClickBtn:(id)sender;

@end


@interface WeatherReportView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *majorLabel;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIButton *changeCityBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *pickerDoneBtn;
@property (nonatomic, strong) UIButton *pickerCancelBtn;

@property (nonatomic, strong) UILabel *firstTip;
@property (nonatomic, strong) UILabel *firstSubTip;
@property (nonatomic, strong) UILabel *secondTip;
@property (nonatomic, strong) UILabel *secondSubTip;

@property (nonatomic, strong) id<WeatherReportBtn> delegate;

@end

NS_ASSUME_NONNULL_END
