//
//  TemViewController.m
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import "TemViewController.h"

#import "WeatherReportTableViewCell.h"
#import "WeatherReportCollectionViewCell.h"
#import "TemViewModel.h"



@interface TemViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,WeatherReportBtn>
//pick显示的数据
@property (nonatomic, strong) NSArray *pickerArr;
//处理后的天气数据
@property (nonatomic, strong) NSArray *temArr;
@property (nonatomic, strong) NSArray *weaArr;

@property (nonatomic, assign) BOOL isDataPrepared;
@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *weaDic;

//conllection显示的数据
@property (nonatomic, strong) NSMutableArray *colletionDisplayWea;
@property (nonatomic, strong) NSMutableArray *colletionDisplayTem;

//当前城市
@property (nonatomic, copy) NSString *currentCity;

//当前时间
@property (nonatomic, assign) NSInteger currentHour;
@property (nonatomic, assign) NSInteger currentDay;

//临时变量
@property (nonatomic, copy) NSString *tempCity;

@end

@implementation TemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weatherReportView = [[WeatherReportView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.weatherReportView];
    self.weatherReportView.tableView.delegate = self;
    self.weatherReportView.tableView.dataSource = self;
    self.weatherReportView.collectionView.delegate = self;
    self.weatherReportView.collectionView.dataSource = self;
    self.weatherReportView.pickerView.delegate = self;
    self.weatherReportView.pickerView.dataSource = self;
    self.weatherReportView.delegate = self;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123.jpeg"]];
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
    self.colletionDisplayWea = [NSMutableArray arrayWithCapacity:7];
    self.colletionDisplayTem = [NSMutableArray arrayWithCapacity:7];
    
    self.isDataPrepared = NO;
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
    NSString *time = [TemViewModel getCurrentDate];
    NSArray  *temp = [time componentsSeparatedByString:@" "];
    NSArray  *temp2 = [temp[1] componentsSeparatedByString:@":"];
    NSArray  *temp3 = [time componentsSeparatedByString:@"-"];
    
    NSInteger hour = [temp2[0] intValue];
    if(hour < 8){
        hour = 8;
    }
    self.currentHour = hour;
    NSInteger day= [temp3[2] intValue];
    self.currentDay = day;
    
    self.temArr = [[[WeaDataDic valueForKey:@"data"] valueForKey:@"hours"] valueForKey:@"tem"];//一周的数据 前三天每隔1h 后四天每隔3h 从早上八点开始
    //NSLog(@"%@",self.temArr );
    self.weaArr = [[[WeaDataDic valueForKey:@"data"] valueForKey:@"hours"] valueForKey:@"wea_img"];//一周的数据 前三天每隔1h 后四天每隔3h 从早上八点开始
    //NSLog(@"%@",self.weaArr);
    //准备将要显示的数据
    int hourCount = 0;
    int i = (int)hour - 8;
    int j = 0;
    while(hourCount < 7)
    {
        [self.colletionDisplayTem addObject:self.temArr[j][i]];
        [self.colletionDisplayWea addObject:self.weaArr[j][i]];
        if(i + 3 > 23){
            i = (i + 3) % 24;
            j = j + 1;
        }else{
            i += 3;
        }
        ++hourCount;
    }
    NSLog(@"data is prepared");
    self.isDataPrepared = YES;
    
    [self.weatherReportView.tableView reloadData];
    [self.weatherReportView.collectionView reloadData];
    self.weatherReportView.topLabel.text = self.currentCity;
    self.weatherReportView.majorLabel.text = [NSString stringWithFormat:@"%2d度",[[self.colletionDisplayTem objectAtIndex:0] intValue]];
    self.weatherReportView.subLabel.text = [self.weaDic valueForKey:[self.colletionDisplayWea objectAtIndex:0]];
    self.weatherReportView.hintLabel.text = [NSString stringWithFormat:@"最高气温：%d度 最低气温：%d度",[[[self.temArr objectAtIndex:0] valueForKeyPath:@"@max.intValue"] intValue],[[[self.temArr objectAtIndex:0] valueForKeyPath:@"@min.intValue"] intValue]];
}

- (void)p_updateData{
//    NSDictionary* WeaDataDic = [TemViewModel fetchDataWithCityID:[self.cityDic valueForKey: self.currentCity]];
    [TemViewModel fetchDataWithCityID:[self.cityDic valueForKey: self.currentCity] withblock:^(NSDictionary* dic){
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
    [self.colletionDisplayTem  removeAllObjects];
    [self.colletionDisplayWea removeAllObjects];
    self.isDataPrepared = NO;
    self.currentCity = self.tempCity;
    
    NSLog(@"qian - %@",self.currentCity);
    [self p_updateData];
    //[self p_updateView];
    NSLog(@"hou - %@",self.currentCity);
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

#pragma mark --UITableViewDataSource 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherReportTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    if(self.isDataPrepared == YES){
        cell.labelDate.text = [NSString stringWithFormat:@"%02ld号",self.currentDay + indexPath.row];
        cell.WeatherImageView.image = [UIImage imageNamed:[self.weaArr[indexPath.row] objectAtIndex:0]];//选择的每天第一小时天气
        cell.labelMaxTem.text = [NSString stringWithFormat:@"%2d度",[[self.temArr[indexPath.row] valueForKeyPath:@"@max.intValue"] intValue]];
        cell.labelMinTem.text = [NSString stringWithFormat:@"%2d度",[[self.temArr[indexPath.row] valueForKeyPath:@"@min.intValue"] intValue]];
    }
    //NSLog(@"%d",indexPath.row);
    return cell;

}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherReportCollectionViewCell" forIndexPath:indexPath];
    if(self.isDataPrepared == YES){
        cell.labelDate.text = [NSString stringWithFormat:@"%02ld时",(self.currentHour + indexPath.row * 3) % 24];
        cell.weatherLabel.text = [NSString stringWithFormat:@"%2d度",[[self.colletionDisplayTem objectAtIndex:indexPath.row] intValue]];
        cell.weatherImageView.image = [UIImage imageNamed:[self.colletionDisplayWea objectAtIndex:indexPath.row]];
    }
    return cell;
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
