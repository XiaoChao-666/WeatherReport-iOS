//
//  TwoViewController.m
//  pro1
//
//  Created by ByteDance on 2022/7/15.
//

#import "TwoViewController.h"
#import <AFNetworking.h>
#import <Masonry.h>

@interface TwoViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSDictionary *cityDic;
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, copy) NSString *tempCity;
@property (nonatomic, strong) NSArray *pickerArr;

@property (nonatomic, strong) UIButton *changeCityBtn;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *pickerDoneBtn;
@property (nonatomic, strong) UIButton *pickerCancelBtn;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *airLabel;
@property (nonatomic, strong) UILabel *airQuaLabel;
@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentCity = @"成都";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"456.jpeg"]];
    imgView.frame = self.view.bounds;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imgView];
    
    [self p_initData];
    [self p_AFNGetUrlAndUpdate];
    
    [self p_initTopLable];
    [self p_initTopImage];
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
    self.airLabel = [[UILabel alloc] init];
    self.airLabel.text = @"100";
    self.airLabel.font = [UIFont systemFontOfSize:50];
    [self.view addSubview:self.airLabel];
    [self.airLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    //self.weaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 260 , self.view.frame.origin.y + 135, 100, 100)];
    self.airQuaLabel = [[UILabel alloc] init];
    self.airQuaLabel.text = @"差";
    self.airQuaLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.airQuaLabel];
    [self.airQuaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.airLabel);
        make.left.equalTo(self.airLabel.mas_right).offset(5);
    }];
    
    //self.mostWeaLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 100 , self.view.frame.origin.y + 180, 300, 100)];
    self.hintLabel = [[UILabel alloc] init];
    self.hintLabel.text = @"最高气温：0度 最低气温：0度";
    self.hintLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.airLabel.mas_bottom).offset(20);
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

- (void)p_AFNGetUrlAndUpdate{
    //网络请求
    NSString *urlString = [NSString stringWithFormat:@"https://yiketianqi.com/api?unescape=1&version=v1&appid=59632127&appsecret=78bXzRL3&cityid=%@",[self.cityDic valueForKey: self.currentCity]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //NSLog(@"请求成功的数据转换为字典 === %@",dataDic);

        NSLog(@"data is prepared");
        //NSLog(@"t is %@",self.colletionDisplayTem);
        //NSLog(@"w is %@",self.colletionDisplayWea);
        //更新数据
        self.topLabel.text = self.currentCity;

//        NSLog(@"11111111111111111%@",[[dataDic objectForKey:@"data"][0] objectForKey:@"air"]);
        NSInteger airLevel = [[[dataDic objectForKey:@"data"][0] objectForKey:@"air"] intValue];
        self.airLabel.text = [@(airLevel) stringValue];
        if(airLevel < 60){
            self.airQuaLabel.text = @"差";
            self.hintLabel.text = @"空气不好，请戴好口罩";
        }else if(airLevel < 80){
            self.airQuaLabel.text = @"良";
            self.hintLabel.text = @"空气较好，减肥正当时";
        }else{
            self.airQuaLabel.text = @"优";
            self.hintLabel.text = @"空气很好，出去玩玩吧";
        }
     }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
              NSLog(@"%@",error);
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
        make.top.equalTo(self.airLabel).offset(20);
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

- (void)p_initData{
    
    NSArray *objArray = @[@"成都",@"北京",@"上海"];
    NSArray *keyArray = @[@"101270101",@"101010100",@"101020200"];
    self.cityDic = [NSDictionary dictionaryWithObjects:keyArray forKeys:objArray];
}

- (void)pickerDone
{
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
