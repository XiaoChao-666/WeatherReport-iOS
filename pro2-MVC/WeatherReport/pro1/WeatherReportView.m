//
//  WeatherReportView.m
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import "WeatherReportView.h"
#import "WeatherReportTableViewCell.h"
#import "WeatherReportCollectionViewCell.h"

#import <Masonry.h>


@implementation WeatherReportView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_addSubviews];
        [self p_addPositionConstraints];
        
    }
    return self;
}

- (void)p_addSubviews
{
    [self addSubview:self.tableView];
    [self addSubview:self.collectionView];
    [self addSubview:self.topLabel];
    [self addSubview:self.majorLabel];
    [self addSubview:self.subLabel];
    [self addSubview:self.hintLabel];
    [self addSubview:self.changeCityBtn];
    [self addSubview:self.pickerView];
    [self addSubview:self.pickerDoneBtn];
    [self addSubview:self.pickerCancelBtn];
}
- (void)p_addPositionConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-100);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width,250));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hintLabel).offset(70);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width,150));
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.centerX.equalTo(self);
    }];
    
    [self.majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel).offset(100);
        make.centerX.equalTo(self);
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.majorLabel);
        make.left.equalTo(self.majorLabel.mas_right).offset(5);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.majorLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
    [self.changeCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self.topLabel);
        make.size.mas_equalTo(CGSizeMake(50.f,50.f));
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.majorLabel).offset(20);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width,200));
    }];
    
    [self.pickerDoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickerView).offset(10);
        make.left.equalTo(self).offset(10);
    }];
    
    [self.pickerCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickerView).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    
}

- (UITableView*)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:[WeatherReportTableViewCell class] forCellReuseIdentifier:@"WeatherReportTableViewCell"];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
        _tableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (UICollectionView*)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 150);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 15;
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero  collectionViewLayout:layout];
        [_collectionView registerClass:[WeatherReportCollectionViewCell class]  forCellWithReuseIdentifier:@"WeatherReportCollectionViewCell" ];
//        self.collectionView.delegate = self;
//        self.collectionView.dataSource = self;
        _collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (UILabel*)topLabel{
    if(!_topLabel){
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = @"北京";
        _topLabel.font = [UIFont systemFontOfSize:40];
        [self addSubview:_topLabel];
    }
    return _topLabel;
}

- (UILabel*)majorLabel{
    if(!_majorLabel){
        _majorLabel = [[UILabel alloc] init];
        _majorLabel.text = @"0";
        _majorLabel.font = [UIFont systemFontOfSize:50];
        [self addSubview:_majorLabel];
    }
    return _majorLabel;
}

- (UILabel*)subLabel{
    if(!_subLabel){
        _subLabel = [[UILabel alloc] init];
        _subLabel.text = @"晴";
        _subLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_subLabel];
    }
    return _subLabel;
}

- (UILabel*)hintLabel{
    if(!_hintLabel){
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.text = @"最高气温：0度 最低气温：0度";
        _hintLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_hintLabel];
    }
    return _hintLabel;
}

- (UIButton*)changeCityBtn{
    if(!_changeCityBtn){
        _changeCityBtn = [[UIButton alloc] init];
        [_changeCityBtn setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        _changeCityBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_changeCityBtn addTarget:self action:@selector(p_changeCityBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_changeCityBtn];
    }
    return _changeCityBtn;
}

- (UIPickerView*)pickerView{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.backgroundColor = [UIColor colorWithWhite:3.f alpha:0.6];
        [self addSubview:_pickerView];
        [self bringSubviewToFront:_pickerView];
    }
    return _pickerView;
}

- (UIButton*)pickerDoneBtn{
    if(!_pickerDoneBtn){
        _pickerDoneBtn = [[UIButton alloc] init];
        [_pickerDoneBtn setTitle:@"done" forState:UIControlStateNormal];
        [_pickerDoneBtn setBackgroundColor: [UIColor blueColor]];
        [_pickerDoneBtn addTarget:self action:@selector(p_pickerDone:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pickerDoneBtn];
    }
    return _pickerDoneBtn;
}

- (UIButton*)pickerCancelBtn{
    if(!_pickerCancelBtn){
        _pickerCancelBtn = [[UIButton alloc] init];
        [_pickerCancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
        [_pickerCancelBtn setBackgroundColor: [UIColor blueColor]];
        [_pickerCancelBtn addTarget:self action:@selector(p_pickerCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pickerCancelBtn];
    }
    return _pickerCancelBtn;
}


- (void)p_changeCityBtnclick:(UIButton*)sender{
    [_delegate respondsToSelector:@selector(changeCityClickBtn:)] ? [_delegate changeCityClickBtn:sender] : nil;
}

- (void)p_pickerDone:(UIButton*)sender{
    [_delegate respondsToSelector:@selector(pickDoneClickBtn:)] ? [_delegate pickDoneClickBtn:sender] : nil;
}

- (void)p_pickerCancel:(UIButton*)sender{
    [_delegate respondsToSelector:@selector(pickCancelClickBtn:)] ? [_delegate pickCancelClickBtn:sender] : nil;
}
@end
