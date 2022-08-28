//
//  AirViewController.m
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import "AirViewController.h"
#import "WeatherReportDataController.h"


@interface AirViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,WeatherReportBtn>

//临时变量
@property (nonatomic, copy) NSString *tempCity;
@property (nonatomic, strong) WeatherReportDataController* temDataController;

@end

@implementation AirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"空气质量";
    
    self.weatherReportView = [[WeatherReportView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.weatherReportView];
    self.weatherReportView.pickerView.delegate = self;
    self.weatherReportView.pickerView.dataSource = self;
    self.weatherReportView.delegate = self;
    
    
    self.weatherReportView.collectionView.hidden = YES;
    self.weatherReportView.tableView.hidden = YES;

    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"456.jpeg"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imgView];
    [self.view bringSubviewToFront:self.weatherReportView];
    
    self.temDataController = [[WeatherReportDataController alloc] init];
    
    [self p_init];
    [self p_updateViewData];
}

- (void)p_init{
    self.tempCity = self.temDataController.currentCity;
    
    self.weatherReportView.pickerView.hidden = YES;
    self.weatherReportView.pickerDoneBtn.hidden = YES;
    self.weatherReportView.pickerCancelBtn.hidden = YES;
}

-(void)p_updateView {
   
    NSLog(@"data is prepared");
    self.weatherReportView.topLabel.text = self.temDataController.currentCity;
    self.weatherReportView.majorLabel.text = self.temDataController.airQua;
    self.weatherReportView.subLabel.text = self.temDataController.airLevel;
    self.weatherReportView.hintLabel.text = self.temDataController.airTips;
    
    self.weatherReportView.firstTip.text = self.temDataController.winSpeedTip;
    self.weatherReportView.secondTip.text = self.temDataController.weaTip;
}

- (void)p_updateViewData{
//    NSDictionary* WeaDataDic = [TemViewModel fetchDataWithCityID:[self.cityDic valueForKey: self.currentCity]];
    [self.temDataController fetchDataWithCityID:[self.temDataController.cityDic valueForKey: self.temDataController.currentCity] withblock:^{
        [self p_updateView];
    }];
}



- (void)changeCityClickBtn:(UIButton*)sender
{
    self.weatherReportView.pickerView.hidden = NO;
    self.weatherReportView.pickerDoneBtn.hidden = NO;
    self.weatherReportView.pickerCancelBtn.hidden = NO;
    
    self.weatherReportView.firstSubTip.hidden = YES;
}

- (void)pickDoneClickBtn:(UIButton*)sender
{
    self.temDataController.currentCity = self.tempCity;
    
    [self p_updateViewData];
    
    self.weatherReportView.pickerView.hidden = YES;
    self.weatherReportView.pickerDoneBtn.hidden = YES;
    self.weatherReportView.pickerCancelBtn.hidden = YES;
    
    self.weatherReportView.firstSubTip.hidden = NO;
}

- (void)pickCancelClickBtn:(UIButton*)sender
{
    self.weatherReportView.pickerView.hidden = YES;
    self.weatherReportView.pickerDoneBtn.hidden = YES;
    self.weatherReportView.pickerCancelBtn.hidden = YES;
    
    self.weatherReportView.firstSubTip.hidden = NO;
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.temDataController.pickerArr count];
}
 
#pragma mark- Picker View Delegate
 
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.tempCity = [self.temDataController.pickerArr objectAtIndex:row];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.temDataController.pickerArr objectAtIndex:row];
}
@end
