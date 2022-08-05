//
//  AirViewController.m
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import "AirViewController.h"
#import "AirViewModel.h"


@interface AirViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,WeatherReportBtn>
//pick显示的数据
@property (nonatomic, strong) NSArray *pickerArr;


@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *weaDic;

//当前城市
@property (nonatomic, copy) NSString *currentCity;

//临时变量
@property (nonatomic, copy) NSString *tempCity;

@end

@implementation AirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.weatherReportView = [[WeatherReportView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.weatherReportView];
    self.weatherReportView.pickerView.delegate = self;
    self.weatherReportView.pickerView.dataSource = self;
    self.weatherReportView.delegate = self;
//    self.weatherReportView.collectionView.hidden = YES;
//    self.weatherReportView.tableView.hidden = YES;

    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"456.jpeg"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imgView];
    [self.view bringSubviewToFront:self.weatherReportView];
    
    [self p_initData];
    [self p_updateData];
}

- (void)p_initData{
    
    self.currentCity = @"北京";
    self.tempCity = @"北京";
    self.pickerArr = [[NSArray alloc]initWithObjects:@"北京",@"上海",@"成都", nil];
    NSArray *objArray = @[@"成都",@"北京",@"上海"];
    NSArray *keyArray = @[@"101270101",@"101010100",@"101020200"];
    self.cityDic = [NSDictionary dictionaryWithObjects:keyArray forKeys:objArray];
    
    NSArray *objArray2 = @[@"qing",@"yun",@"yin",@"xue",@"yu"];
    NSArray *keyArray2 = @[@"晴",@"云",@"阴",@"雪",@"雨"];
    self.weaDic = [NSDictionary dictionaryWithObjects:keyArray2 forKeys:objArray2];
    
    self.weatherReportView.pickerView.hidden = YES;
    self.weatherReportView.pickerDoneBtn.hidden = YES;
    self.weatherReportView.pickerCancelBtn.hidden = YES;
}

-(void)p_updateView:(NSDictionary*) WeaDataDic{
   
    NSLog(@"data is prepared");
    self.weatherReportView.topLabel.text = self.currentCity;
    NSInteger airLevel = [[[WeaDataDic objectForKey:@"data"][0] objectForKey:@"air"] intValue];
    self.weatherReportView.majorLabel.text = [@(airLevel) stringValue];
    if(airLevel < 60){
        self.weatherReportView.subLabel.text = @"差";
        self.weatherReportView.hintLabel.text = @"空气不好，请戴好口罩";
    }else if(airLevel < 80){
        self.weatherReportView.subLabel.text = @"良";
        self.weatherReportView.hintLabel.text = @"空气较好，减肥正当时";
    }else{
        self.weatherReportView.subLabel.text = @"优";
        self.weatherReportView.hintLabel.text = @"空气很好，出去玩玩吧";
    }
}

- (void)p_updateData{
//    NSDictionary* WeaDataDic = [TemViewModel fetchDataWithCityID:[self.cityDic valueForKey: self.currentCity]];
    [AirViewModel fetchDataWithCityID:[self.cityDic valueForKey: self.currentCity] withblock:^(NSDictionary* dic){
        [self p_updateView:dic];
    }];
}



- (void)changeCityClickBtn:(UIButton*)sender
{
    self.weatherReportView.pickerView.hidden = NO;
    self.weatherReportView.pickerDoneBtn.hidden = NO;
    self.weatherReportView.pickerCancelBtn.hidden = NO;
}

- (void)pickDoneClickBtn:(UIButton*)sender
{
    self.currentCity = self.tempCity;
    
    [self p_updateData];
    
    self.weatherReportView.pickerView.hidden = YES;
    self.weatherReportView.pickerDoneBtn.hidden = YES;
    self.weatherReportView.pickerCancelBtn.hidden = YES;
}

- (void)pickCancelClickBtn:(UIButton*)sender
{
    self.weatherReportView.pickerView.hidden = YES;
    self.weatherReportView.pickerDoneBtn.hidden = YES;
    self.weatherReportView.pickerCancelBtn.hidden = YES;
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickerArr count];
}
 
#pragma mark- Picker View Delegate
 
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.tempCity = [self.pickerArr objectAtIndex:row];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArr objectAtIndex:row];
}
@end
