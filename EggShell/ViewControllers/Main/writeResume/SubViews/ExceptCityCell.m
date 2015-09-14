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
@property (strong,nonatomic)NSMutableArray * pickDataArray;
@property (strong,nonatomic)NSMutableArray * dataArray;
@property (strong,nonatomic)NSMutableArray * IDArray;
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
    self.proviceBtn.tag = 505;
    record_btn = self.proviceBtn;
}

- (IBAction)cityClick:(UIButton *)sender {
    self.pickDataArray = @[@"北京"];
    [self createPickView];
    self.cityBtn.tag = 506;
    record_btn = self.cityBtn;
}

- (IBAction)countyBtn:(UIButton *)sender {
    [self createPickView];
    self.countyBtn.tag = 507;
    record_btn = self.countyBtn;
//    NSDictionary *dic = @{@"name":@"不限",@"id":@"0"};
//    [self.dataArray addObject:dic];
    self.pickDataArray = self.dataArray;
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
    
    sexOk = [ZCControl createButtonWithFrame:CGRectMake(0, 0, 100, 100) ImageName:@"" Target:self Action:@selector(sexOkClick) Title:@"确定"];
    
    [sexOk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    sexOk.backgroundColor = [UIColor redColor];
    [self.Controller.navigationController.view addSubview:sexOk];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.pickerView.frame = CGRectMake(0, HEIGHT / 2 + 90*MyHeight, WIDETH, HEIGHT / 2 - 80);
        sexOk.frame = CGRectMake(WIDETH - 50, HEIGHT -100*MyHeight, 40, 30);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)sexOkClick
{
    [backView removeFromSuperview];
    
    [self.pickerView removeFromSuperview];
    
    [sexOk removeFromSuperview];
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    [record_btn setTitle:self.pickDataArray[row] forState:UIControlStateSelected];
    
    if(record_btn.tag == 505)
    {
        self.proviceClick(2);
    }
    if(record_btn.tag == 506)
    {
        self.cityClick(52);
    }
    
    if(record_btn.tag == 507)
    {
        self.threecityClick([self.IDArray[row] intValue]);
    }
    record_btn.selected = YES;
    
}

-(void)config:(NSMutableArray *)dataArray
{
    
//    {
//        display = 1;
//        id = 500;
//        keyid = 52;
//        letter = D;
//        name = "\U4e1c\U57ce\U533a";
//        sitetype = 0;
//        sort = 0;
//    }
    
//    NSDictionary *dic = @{@"display":@"1",@"id":@"0",@"keyid":@"0",@"letter":@"0",@"name":@"不限",@"sitetype":@"0",@"sort":@"0"};
////    [dataArray addObject:dic];
//    [dataArray arrayByAddingObject:dic];

    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.IDArray = [NSMutableArray arrayWithCapacity:0];
    for(int i = 0;i < dataArray.count ;i++)
    {
        if (i == 0)
        {
            
            [self.dataArray addObject:@"全城"];
            [self.IDArray addObject:@"0"];
        }
            [self.dataArray addObject:dataArray[i][@"name"]];
            [self.IDArray addObject:dataArray[i][@"id"]];
       
    }
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
