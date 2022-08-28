//
//  TemViewController.m
//  pro1
//
//  Created by ByteDance on 2022/8/4.
//

#import "TemViewController.h"

#import "WeatherReportTableViewCell.h"
#import "WeatherReportCollectionViewCell.h"
#import "WeatherReportDataController.h"



@interface TemViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,WeatherReportBtn>

@property (nonatomic, assign) BOOL isDataPrepared;
//临时变量
@property (nonatomic, copy) NSString *tempCity;

@property (nonatomic, strong) WeatherReportDataController* temDataController;

@end

@implementation TemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"天气预报";
    
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
    
    self.temDataController = [[WeatherReportDataController alloc] init];
    
    self.weatherReportView.firstTip.hidden = YES;
    self.weatherReportView.firstSubTip.hidden = YES;
    self.weatherReportView.secondTip.hidden = YES;
    self.weatherReportView.secondSubTip.hidden = YES;
    
    [self p_init];
    [self p_updateViewData];
}

- (void)p_init{
    self.tempCity = self.temDataController.currentCity;
    self.isDataPrepared = NO;
    
    self.weatherReportView.pickerView.hidden = YES;
    self.weatherReportView.pickerDoneBtn.hidden = YES;
    self.weatherReportView.pickerCancelBtn.hidden = YES;
}

-(void)p_updateView{
    NSLog(@"data is prepared");
    self.isDataPrepared = YES;
    
    [self.weatherReportView.tableView reloadData];
    [self.weatherReportView.collectionView reloadData];
    self.weatherReportView.topLabel.text = self.temDataController.currentCity;
    self.weatherReportView.majorLabel.text = [NSString stringWithFormat:@"%2d度",[[self.temDataController.temArr objectAtIndex:self.temDataController.currentHour] intValue]];
    self.weatherReportView.subLabel.text = [self.temDataController.weaDic valueForKey:[self.temDataController.weaImgArr objectAtIndex:self.temDataController.currentHour]];
    NSMutableArray<NSString *> *tempArr = [[NSMutableArray alloc] init];
    NSArray *hoursData = [[self.temDataController.dayDataArr objectAtIndex:0] objectForKey:@"hours"];
    for(NSDictionary *obj in hoursData) {
        [tempArr addObject:[obj objectForKey:@"tem"]];
    }
    self.weatherReportView.hintLabel.text = [NSString stringWithFormat:@"最高气温：%d度 最低气温：%d度",[[tempArr valueForKeyPath:@"@max.intValue"] intValue],[[tempArr valueForKeyPath:@"@min.intValue"] intValue]];
}

- (void)p_updateViewData{
    [self.temDataController fetchDataWithCityID:[self.temDataController.cityDic valueForKey: self.temDataController.currentCity] withblock:^{
        [self p_updateView];
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
    self.isDataPrepared = NO;
    self.temDataController.currentCity = self.tempCity;
    
    [self p_updateViewData];
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
        return [self.temDataController.dayDataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherReportTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    if(self.isDataPrepared == YES){
        cell.labelDate.text = [[self.temDataController.dayDataArr objectAtIndex:indexPath.row] objectForKey:@"day"];
        cell.WeatherImageView.image = [UIImage imageNamed:[[self.temDataController.dayDataArr objectAtIndex:indexPath.row] objectForKey:@"wea_img"]];
        NSMutableArray<NSString *> *tempArr = [[NSMutableArray alloc] init];
        NSArray *hoursData = [[self.temDataController.dayDataArr objectAtIndex:indexPath.row] objectForKey:@"hours"];
        for(NSDictionary *obj in hoursData) {
            [tempArr addObject:[obj objectForKey:@"tem"]];
        }
        
        cell.labelMaxTem.text = [NSString stringWithFormat:@"%2d度",[[tempArr valueForKeyPath:@"@max.intValue"] intValue]];
        cell.labelMinTem.text = [NSString stringWithFormat:@"%2d度",[[tempArr valueForKeyPath:@"@min.intValue"] intValue]];
    }
    return cell;

}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.temDataController.temArr count] - self.temDataController.currentHour;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherReportCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherReportCollectionViewCell" forIndexPath:indexPath];
    if(self.isDataPrepared == YES){
        cell.labelDate.text = [NSString stringWithFormat:@"%02ld时",(indexPath.row + self.temDataController.currentHour) % 24];
        cell.weatherLabel.text = [NSString stringWithFormat:@"%2d度",[[self.temDataController.temArr objectAtIndex:indexPath.row + self.temDataController.currentHour] intValue]];
        cell.weatherImageView.image = [UIImage imageNamed:[self.temDataController.weaImgArr objectAtIndex:indexPath.row + self.temDataController.currentHour]];
    }
    return cell;
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
