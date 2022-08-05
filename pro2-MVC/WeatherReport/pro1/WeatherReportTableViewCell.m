//
//  tableView1Cell.m
//  pro1
//
//  Created by ByteDance on 2022/7/19.
//

#import "WeatherReportTableViewCell.h"
#import <Masonry.h>

@implementation WeatherReportTableViewCell

//- (id)initWithFrame:(CGRect)frame
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    //self = [super initWithFrame:frame];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //self.labelDate = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 20, self.frame.origin.y, 80, self.frame.size.height)];
        self.labelDate = [[UILabel alloc] init];
        self.labelDate.textAlignment = NSTextAlignmentCenter;
        self.labelDate.font = [UIFont systemFontOfSize:15];
        //self.labelDate.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.labelDate];
        [self.labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];

        //self.WeatherImageView = [[UIImageView alloc] initWithFrame: CGRectMake(self.frame.origin.x + cellWidth - 140,self.frame.origin.y,40,self.frame.size.height)];
        self.WeatherImageView = [[UIImageView alloc] init];
        [self addSubview:self.WeatherImageView];
        [self.WeatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.labelDate.mas_right).offset(110);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40,self.frame.size.height));
        }];
        
        
        //self.labelMinTem = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + cellWidth + 40, self.frame.origin.y, 20, self.frame.size.height)];
        self.labelMinTem = [[UILabel alloc] init];
        self.labelMinTem.textAlignment = NSTextAlignmentCenter;
        self.labelMinTem.font = [UIFont systemFontOfSize:12];
        //self.labelMinTem.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.labelMinTem];
        [self.labelMinTem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(self);
        }];
        
        //self.labelMaxTem = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + cellWidth, self.frame.origin.y, 20, self.frame.size.height)];
        self.labelMaxTem = [[UILabel alloc] init];
        self.labelMaxTem.textAlignment = NSTextAlignmentCenter;
        self.labelMaxTem.font = [UIFont systemFontOfSize:12];
        //self.labelMaxTem.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.labelMaxTem];
        [self.labelMaxTem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.labelMinTem.mas_left).offset(-20);
            make.centerY.equalTo(self);
        }];
        

        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
