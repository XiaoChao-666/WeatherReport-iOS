//
//  ViewController2.m
//  pro1
//
//  Created by ByteDance on 2022/6/24.
//

#import "ViewController2.h"

@interface ViewController2 ()<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) UITextField* textField;
@property (strong, nonatomic) UILabel* labelName;
@property (strong, nonatomic) UITextView* textView;
@property (strong, nonatomic) UILabel* labelAbstract;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    CGFloat textFieldWidth = 223;
    CGFloat textFieldHeight = 30;
    CGFloat textFieldTopView = 150;
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake((screen.size.width - textFieldWidth)/2,textFieldTopView,textFieldWidth,textFieldHeight)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.delegate = self;
    
    [self.view addSubview:self.textField];
    CGFloat labelNameTextFieldSpace = 30;
    self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y - labelNameTextFieldSpace, 51, 21)];
    self.labelName.text = @"Name:";
    [self.view addSubview:self.labelName];
    
    CGFloat textViewWidth = 236;
    CGFloat textViewHeight = 198;
    CGFloat textViewTopView = 240;
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake((screen.size.width - textViewWidth)/2 , textViewTopView, textViewWidth, textViewHeight)];
    
    self.textView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    
    self.textView.delegate = self;
    
    [self.view addSubview:self.textView];
    
    //labelName标签与textView之间的距离
    CGFloat labelAbstractTextViewSpace = 30;
    self.labelAbstract = [[UILabel alloc] initWithFrame:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y - labelAbstractTextViewSpace, 103, 21)];
    self.labelAbstract.text = @"Abstract:";
    [self.view addSubview:self.labelAbstract];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 实现UITextFieldDelegate委托协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"TextField获得焦点，点击return键");
    return TRUE;
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
