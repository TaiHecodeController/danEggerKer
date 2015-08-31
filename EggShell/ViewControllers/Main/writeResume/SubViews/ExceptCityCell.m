//
//  ExceptCityCell.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ExceptCityCell.h"
@interface ExceptCityCell ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView * backView;
    UIButton * sexOk;
    UIButton * record_btn;
}
@property (strong,nonatomic)UIPickerView * pickerView;
@property (strong,nonatomic)NSArray * pickDataArray;
@end
@implementation ExceptCityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)exceptClick:(UIButton *)sender {
    self.pickDataArray = @[@"北京"];
    [self createPickView];
    record_btn = self.proviceBtn;
}

- (IBAction)cityClick:(UIButton *)sender {
    self.pickDataArray = @[@"北京"];
    [self createPickView];
    record_btn = self.cityBtn;
}

- (IBAction)countyBtn:(UIButton *)sender {
    self.pickDataArray = @[@"东城区",@"西城区",@"朝阳区",@"海淀区",@"石景山区",@"丰台区",@"顺义区",@"怀柔区",@"密云县",@"延庆县",@"昌平区",@"平谷区",@"门头沟区",@"房山区",@"通州区"];
    [self createPickView];
    record_btn = self.countyBtn;
    
}

-(void)createPickView
{
    //数据源
    
    
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
    [record_btn setTitle:self.pickDataArray[row] forState:UIControlStateNormal];
    record_btn.selected = YES;
    
}

//pickView代理

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickDataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickDataArray[row];
}


@end
