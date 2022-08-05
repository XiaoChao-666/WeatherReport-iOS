//
//  ViewController.m
//  pro1
//
//  Created by ByteDance on 2022/6/22.
//

#import "ViewController.h"
#import "EventCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    int COL_NUM;//每一行有几个单元格
}
//@property (strong, nonatomic) NSArray * events;

@property (strong, nonatomic) UICollectionView* collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:@"events"
//                                           ofType:@"plist"];
    //获取属性列表文件中的全部数据
//    self.events = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    COL_NUM = 2;
    
    [self setupCollectionView];
}

- (void) setupCollectionView {
    
    // 1.创建流式布局布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置每个格子的尺寸
    layout.itemSize = CGSizeMake(150, 150);
    // 3.设置整个collectionView的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 4.设置每一行之间的间距
    layout.minimumLineSpacing = 10;
    // 5.设置单元格之间的间距
    layout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    //设置可重用单元格标识与单元格类型
    [self.collectionView registerClass:[EventCollectionViewCell class]  forCellWithReuseIdentifier:@"cellIdentifier" ];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self.view addSubview:self.collectionView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
//    int num = [self.events count] % COL_NUM;
//    if (num == 0) {//偶数
//        return [self.events count] / COL_NUM;
//    } else {        //奇数
//        return [self.events count] / COL_NUM + 1;
//    }
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return COL_NUM;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.label.text = @"666";
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
