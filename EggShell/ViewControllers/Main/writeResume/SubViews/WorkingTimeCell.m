//
//  WorkingTimeCell.m
//  EggShell
//
//  Created by mac on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WorkingTimeCell.h"
@interface WorkingTimeCell()
{
    NSString * dateStr;
    UIView * backView;
    UIButton * ok;
    UIButton * record_btn;
}
@property (strong,nonatomic)UIDatePicker * dataPicker;
@end

@implementation WorkingTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startTimeClick:(UIButton *)sender {
    [self createDataPickView];
    record_btn = sender;
}

- (IBAction)endTimeClick:(UIButton *)sender {
    if(!self.StartTime.selected)
    {
        [MBProgressHUD creatembHub:@"请选择开始时间"];
        return;
    }
    [self createDataPickView];
    record_btn = sender;
}

- (IBAction)todaySelectClick:(UIButton *)sender {
    //当前时间创建NSDate
    NSDate * localDate = [NSDate date];
    //设置时间
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    dateStr = [dateFormatt stringFromDate:localDate];
    sender.selected = !sender.selected;
    [self.endTime setTitle:dateStr forState:UIControlStateSelected];
    self.endTime.selected = YES;
}

-(void)createDataPickView
{
    backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    [self.controller.navigationController.view addSubview:backView];
    //创建picker
    self.dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDETH, HEIGHT / 2 - 80)];
    self.dataPicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.controller.navigationController.view addSubview:self.dataPicker];
    [self.dataPicker addTarget:self action:@selector(dataChanged:) forControlEvents:UIControlEventValueChanged];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置显示为中文
    self.dataPicker.locale = locale;
    self.dataPicker.datePickerMode = UIDatePickerModeDate;
    //当前时间创建NSDate
    NSDate * localDate = [NSDate date];
    //设置时间
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    NSDate * minDate = [dateFormatt dateFromString:@"1910-1-1"];
    
    //设置属性
    self.dataPicker.maximumDate = localDate;
    self.dataPicker.minimumDate = minDate;
    
    ok = [ZCControl createButtonWithFrame:CGRectMake(WIDETH - 40, HEIGHT, 40, 30) ImageName:@"" Target:self Action:@selector(okClick) Title:@"确定"];
    self.dataPicker.userInteractionEnabled = YES;
    [ok setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.controller.navigationController.view addSubview:ok];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.dataPicker.frame = CGRectMake(0, HEIGHT / 2 + 90*MyHeight, WIDETH, HEIGHT / 2 - 80*MyHeight);
        ok.frame = CGRectMake(WIDETH - 50, HEIGHT - 100*MyHeight, 40, 30);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)okClick
{
    [backView removeFromSuperview];
    
    [self.dataPicker removeFromSuperview];
    
    [ok removeFromSuperview];
    if(dateStr == nil)
    {
        NSDate * localDate = [NSDate date];
        //设置时间
        NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
        [dateFormatt setDateFormat:@"yyyy-MM-dd"];
        dateStr = [dateFormatt stringFromDate:localDate];
    }
    [record_btn setTitle:dateStr forState:UIControlStateNormal];
    record_btn.selected = YES;
    dateStr = nil;
}

-(void)dataChanged:(UIDatePicker *)sender
{
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    dateStr = [dateFormatt stringFromDate:sender.date];
}

@end
