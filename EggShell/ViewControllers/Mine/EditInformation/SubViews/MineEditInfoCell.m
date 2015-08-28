//
//  MineEditInfoCell.m
//  EggShell
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "MineEditInfoCell.h"
#import "EditAddressVC.h"
@interface MineEditInfoCell()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString * dateString;
    UIView * backView;
    UIButton * ok;
    UIButton * sexOk;
}
@property (strong,nonatomic)UIDatePicker * dataPicker;
@property (strong,nonatomic)UIPickerView * pickerView;
@property (strong,nonatomic)NSArray * pickDataArray;
@end

@implementation MineEditInfoCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showAllClick:(UIButton *)sender {
    
}

- (IBAction)contentClick:(UIButton *)sender {
    self.keyBordHideBlock();
    if(sender.tag == 200)
    {
        [self createDataPickView];
    }
    if(sender.tag == 202)
    {
        [self createPickView];
    }
    if(sender.tag == 205)
    {
        [self.Controller.navigationController pushViewController:[[EditAddressVC alloc] init] animated:YES];
    }

}


-(void)createPickView
{
    //数据源
    self.pickDataArray = @[@"男",@"女"];
    
    backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    [self.Controller.navigationController.view addSubview:backView];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDETH, HEIGHT / 2 - 80)];
    [self.Controller.navigationController.view addSubview:self.pickerView];
    self.pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    sexOk = [ZCControl createButtonWithFrame:CGRectMake(WIDETH - 40, HEIGHT, 40, 30) ImageName:@"" Target:self Action:@selector(sexOkClick) Title:@"确定"];

    [sexOk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.Controller.navigationController.view addSubview:sexOk];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.pickerView.frame = CGRectMake(0, HEIGHT / 2 + 80, WIDETH, HEIGHT / 2 - 80);
        sexOk.frame = CGRectMake(WIDETH - 40, HEIGHT - 80, 40, 30);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)sexOkClick
{
    [backView removeFromSuperview];
    
    [self.pickerView removeFromSuperview];
    
    [sexOk removeFromSuperview];
    
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    self.contentTextField.text = self.pickDataArray[row];
}

-(void)createDataPickView
{
    backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    [self.Controller.navigationController.view addSubview:backView];
    //创建picker
    self.dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDETH, HEIGHT / 2 - 80)];
    self.dataPicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.Controller.navigationController.view addSubview:self.dataPicker];
    [self.dataPicker addTarget:self action:@selector(dataChanged:) forControlEvents:UIControlEventValueChanged];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置显示为中文
    self.dataPicker.locale = locale;
    self.dataPicker.datePickerMode = UIDatePickerModeDate;
    //当前时间创建NSDate
    NSDate * localDate = [NSDate date];
    //设置时间
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yy-MM-dd"];
    NSDate * minDate = [dateFormatt dateFromString:@"1910-1-1"];
    
    //设置属性
    self.dataPicker.maximumDate = localDate;
    self.dataPicker.minimumDate = minDate;
    
    ok = [ZCControl createButtonWithFrame:CGRectMake(WIDETH - 40, HEIGHT, 40, 30) ImageName:@"" Target:self Action:@selector(okClick) Title:@"确定"];
    self.dataPicker.userInteractionEnabled = YES;
    [ok setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.Controller.navigationController.view addSubview:ok];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.dataPicker.frame = CGRectMake(0, HEIGHT / 2 + 80, WIDETH, HEIGHT / 2 - 80);
        ok.frame = CGRectMake(WIDETH - 40, HEIGHT - 80, 40, 30);
    } completion:^(BOOL finished) {
        
    }];
}


-(void)okClick
{
    [backView removeFromSuperview];

    [self.dataPicker removeFromSuperview];
   
    [ok removeFromSuperview];
    
    self.contentTextField.text = dateString;
}


-(void)dataChanged:(UIDatePicker *)sender
{
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    dateString = [dateFormatt stringFromDate:sender.date];
}

- (IBAction)nextClick:(UIButton *)sender {

    
}

//pickView代理

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickDataArray[row];
}

@end
