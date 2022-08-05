//
//  OneViewController.m
//  pro1
//
//  Created by ByteDance on 2022/7/15.
//

#import "OneViewController.h"
#import "WeatherReportTableViewCell.h"
#import "WeatherReportCollectionViewCell.h"
#import <AFNetworking.h>
#import <Masonry.h>
 
@interface OneViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource, UICollectionViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UITableView *tableView2;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, assign) NSInteger currentHour;
@property (nonatomic, assign) NSInteger currentDay;

@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, strong) NSDictionary *weaDic;
@property (nonatomic, strong) NSMutableArray *colletionDisplayWea;
@property (nonatomic, strong) NSMutableArray *colletionDisplayTem;
@property (nonatomic, assign) BOOL isDataPrepared;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *temLabel;
@property (nonatomic, strong) UILabel *weaLabel;
@property (nonatomic, strong) UILabel *mostWeaLabel;
@property (nonatomic, strong) UIButton *changeCityBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *pickerDoneBtn;
@property (nonatomic, strong) UIButton *pickerCancelBtn;
@property (nonatomic, copy) NSString *tempCity;


@property (nonatomic, strong) NSArray *pickerArr;
@property (nonatomic, strong) NSArray *temArr;
@property (nonatomic, strong) NSArray *weaArr;

@end

@implementation OneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentCity = @"成都";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123.jpeg"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imgView];
    

    
    [self p_initData];
    [self p_AFNGetUrlAndUpdate];
    
    [self p_initTopLable];
    [self p_initTopImage];
    [self p_initTableView];
    [self p_initCollectionView];
    [self p_initPickerView];
    

}

- (void)p_initTopLable{
    //self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 170 , self.view.frame.origin.y + 15, 100, 100)];
    self.topLabel = [[UILabel alloc] init];
    self.topLabel.text = self.currentCity;
    self.topLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:self.topLabel];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.centerX.equalTo(self.view);
    }];
    
    
    //self.temLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 140 , self.view.frame.origin.y + 120, 200, 100)];
    self.temLabel = [[UILabel alloc] init];
    self.temLabel.text = @"0度";
    self.temLabel.font = [UIFont systemFontOfSize:50];
    [self.view addSubview:self.temLabel];
    [self.temLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    //self.weaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 260 , self.view.frame.origin.y + 135, 100, 100)];
    self.weaLabel = [[UILabel alloc] init];
    self.weaLabel.text = @"晴";
    self.weaLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.weaLabel];
    [self.weaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.temLabel);
        make.left.equalTo(self.temLabel.mas_right).offset(5);
    }];
    
    //self.mostWeaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 100 , self.view.frame.origin.y + 180, 300, 100)];
    self.mostWeaLabel = [[UILabel alloc] init];
    self.mostWeaLabel.text = @"最高气温：0度 最低气温：0度";
    self.mostWeaLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.mostWeaLabel];
    [self.mostWeaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];

}
- (void)p_initTopImage{
    //self.changeCityBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 320 , self.view.frame.origin.y + 40, 50, 50)];
    self.changeCityBtn = [[UIButton alloc] init];
    [self.changeCityBtn setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    self.changeCityBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.changeCityBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeCityBtn];
    [self.changeCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(self.topLabel);
        make.size.mas_equalTo(CGSizeMake(50.f,50.f));
    }];
}

- (void)p_initTableView{
    //self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x , self.view.frame.size.height - 350, self.view.frame.size.width, 280)];
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[WeatherReportTableViewCell class] forCellReuseIdentifier:@"WeatherReportTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
//    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.alpha = 0.5;
    self.tableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-100);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width,250));
    }];
}

- (void)p_initCollectionView{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 150);
    //layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 15;
    //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x , 300, self.view.frame.size.width, 150) collectionViewLayout:layout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero  collectionViewLayout:layout];
    [self.collectionView registerClass:[WeatherReportCollectionViewCell class]  forCellWithReuseIdentifier:@"WeatherReportCollectionViewCell" ];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //self.collectionView.alpha = 0.5;
    self.collectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mostWeaLabel).offset(70);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width,150));
    }];
}

- (void)p_initPickerView{
    self.pickerArr = [[NSArray alloc]initWithObjects:@"北京",@"上海",@"成都", nil];
    self.pickerView = [[UIPickerView alloc] init];
    //self.pickerView.frame = CGRectMake(100, 250, 200, 200);
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.backgroundColor = [UIColor colorWithWhite:3.f alpha:0.6];
    [self.view addSubview:self.pickerView];
//    self.pickerView.showsSelectionIndicator = YES;
    [self.view bringSubviewToFront:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temLabel).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width,200));
    }];
    
    //self.pickerDoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.pickerView.frame.origin.x + 10, self.pickerView.frame.origin.y + 10, 50, 30)];
    self.pickerDoneBtn = [[UIButton alloc] init];
    [self.pickerDoneBtn setTitle:@"done" forState:UIControlStateNormal];
    [self.pickerDoneBtn setBackgroundColor: [UIColor blueColor]];
    [self.pickerDoneBtn addTarget:self action:@selector(pickerDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pickerDoneBtn];
    [self.pickerDoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickerView).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
    
    //self.pickerCancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.pickerView.frame.origin.x + 120, self.pickerView.frame.origin.y + 10, 70, 30)];
    self.pickerCancelBtn = [[UIButton alloc] init];
    [self.pickerCancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
    [self.pickerCancelBtn setBackgroundColor: [UIColor blueColor]];
    [self.pickerCancelBtn addTarget:self action:@selector(pickerCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pickerCancelBtn];
    [self.pickerCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickerView).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];

    self.pickerView.hidden = YES;
    self.pickerDoneBtn.hidden = YES;
    self.pickerCancelBtn.hidden = YES;
}



- (void)p_AFNGetUrlAndUpdate{
    //先求出当前的时间
    NSString *time = [self p_getCurrentDate];
    NSArray  *temp = [time componentsSeparatedByString:@" "];
    NSArray  *temp2 = [temp[1] componentsSeparatedByString:@":"];
    NSArray  *temp3 = [time componentsSeparatedByString:@"-"];
    
    NSInteger hour = [temp2[0] intValue];
    if(hour < 8){
        hour = 8;
    }
    self.currentHour = hour;
    //NSLog(@"hour is %ld",hour);
    //NSInteger mouth= [temp3[1] intValue];
    //NSLog(@"mouth is %ld",mouth);
    NSInteger day= [temp3[2] intValue];
    self.currentDay = day;
    //NSLog(@"day is %ld",day);
    
    
    //网络请求
    NSString *urlString = [NSString stringWithFormat:@"https://yiketianqi.com/api?unescape=1&version=v1&appid=59632127&appsecret=78bXzRL3&cityid=%@",[self.cityDic valueForKey: self.currentCity]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"请求成功的数据转换为字典 === %@",dataDic);
        self.temArr = [[[dataDic valueForKey:@"data"] valueForKey:@"hours"] valueForKey:@"tem"];//一周的数据 前三天每隔1h 后四天每隔3h 从早上八点开始
        //NSLog(@"%@",self.temArr );
        self.weaArr = [[[dataDic valueForKey:@"data"] valueForKey:@"hours"] valueForKey:@"wea_img"];//一周的数据 前三天每隔1h 后四天每隔3h 从早上八点开始
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
        //NSLog(@"t is %@",self.colletionDisplayTem);
        //NSLog(@"w is %@",self.colletionDisplayWea);
        //更新数据
        self.isDataPrepared = YES;
        [self.collectionView reloadData];
        [self.tableView reloadData];
        self.topLabel.text = self.currentCity;
        self.temLabel.text = [NSString stringWithFormat:@"%2d度",[[self.colletionDisplayTem objectAtIndex:0] intValue]];
        self.weaLabel.text = [self.weaDic valueForKey:[self.colletionDisplayWea objectAtIndex:0]];
        self.mostWeaLabel.text = [NSString stringWithFormat:@"最高气温：%d度 最低气温：%d度",[[[self.temArr objectAtIndex:0] valueForKeyPath:@"@max.intValue"] intValue],[[[self.temArr objectAtIndex:0] valueForKeyPath:@"@min.intValue"] intValue]];
     }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
              NSLog(@"%@",error);
     }];

}

- (void)p_initData{
    self.colletionDisplayWea = [NSMutableArray arrayWithCapacity:7];
    self.colletionDisplayTem = [NSMutableArray arrayWithCapacity:7];
    
    self.isDataPrepared = NO;
    NSArray *objArray = @[@"成都",@"北京",@"上海"];
    NSArray *keyArray = @[@"101270101",@"101010100",@"101020200"];
    self.cityDic = [NSDictionary dictionaryWithObjects:keyArray forKeys:objArray];
    
    NSArray *objArray2 = @[@"qing",@"yun",@"yin",@"xue",@"yu"];
    NSArray *keyArray2 = @[@"晴",@"云",@"阴",@"雪",@"雨"];
    self.weaDic = [NSDictionary dictionaryWithObjects:keyArray2 forKeys:objArray2];
}

- (NSString *)p_getCurrentDate {
    NSDate *currentDate = [NSDate date]; // 获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SS"]; // 设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate]; // 将时间转化成字符串
    //NSLog(@"time is %@",dateString);
    return dateString;

}

- (void)pickerDone
{
    [self.colletionDisplayTem  removeAllObjects];
    [self.colletionDisplayWea removeAllObjects];
    self.isDataPrepared = NO;

    self.currentCity = self.tempCity;
    [self p_AFNGetUrlAndUpdate];
    self.pickerView.hidden = YES;
    self.pickerDoneBtn.hidden = YES;
    self.pickerCancelBtn.hidden = YES;
    NSLog(@"11");
}

- (void)pickerCancel
{
    self.pickerView.hidden = YES;
    self.pickerDoneBtn.hidden = YES;
    self.pickerCancelBtn.hidden = YES;
    NSLog(@"22");
}

- (void)click
{
    self.pickerView.hidden = NO;
    self.pickerDoneBtn.hidden = NO;
    self.pickerCancelBtn.hidden = NO;
    NSLog(@"33");
}

#pragma mark --UITableViewDataSource 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherReportTableViewCell" forIndexPath:indexPath];
//    cell.labelDate.text = @"周1";
//    cell.labelMaxTem.text = @"123";
//    cell.labelMinTem.text = @"456";
//    cell.WeatherImageView.image = [UIImage imageNamed:@"3"];
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

//    cell.labelDate.text = @"000";
//    cell.weatherLabel.text = @"ppp";
//    cell.weatherImageView.image = [UIImage imageNamed:@"3"];
    if(self.isDataPrepared == YES){
        cell.labelDate.text = [NSString stringWithFormat:@"%02ld时",(self.currentHour + indexPath.row * 3) % 24];
        cell.weatherLabel.text = [NSString stringWithFormat:@"%2d度",[[self.colletionDisplayTem objectAtIndex:indexPath.row] intValue]];
        cell.weatherImageView.image = [UIImage imageNamed:[self.colletionDisplayWea objectAtIndex:indexPath.row]];
    }
    //NSLog(@"%ld",indexPath.row);
    
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
    //[myTextField setText:[pickerArray objectAtIndex:row]];
    //NSLog(@"%@",[self.pickerArr objectAtIndex:row]);
    self.tempCity = [self.pickerArr objectAtIndex:row];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickerArr objectAtIndex:row];
}

@end
