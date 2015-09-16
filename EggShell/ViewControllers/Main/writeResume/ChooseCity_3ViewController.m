//
//  ChooseCity_3ViewController.m
//  EggShell
//
//  Created by 太和 on 15/9/9.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ChooseCity_3ViewController.h"
#import "JobScreenDetailCell.h"
#import "WriteResumeViewController.h"

@interface ChooseCity_3ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView ;

@end

@implementation ChooseCity_3ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"choosecity3vc"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"choosecity3vc"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    
    [self createTableView];
    
    [self createjobBtn];
}

-(void)createjobBtn
{
    UIView * jobView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-60-64, WIDETH, 60)];
    jobView.backgroundColor = UIColorFromRGB(0xf3f3f1);
    [self.view addSubview:jobView];
}
-(void)createTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(-15, 0, WIDETH+15, HEIGHT-64-60)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator =  NO;
    self.tableView = tableView;
    tableView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    tableView.layer.borderWidth = 0.5;
    tableView.separatorColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
    tableView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    JobScreenDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobScreenDetailCell" owner:self
                                            options:nil] lastObject];
    }
    cell.textLable.text = self.DataArray[indexPath.row][@"name"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 42)];
    bgTitleView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    
    UILabel  * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 13, 200, 16)];
    titleLable.text = self.titleText;
    titleLable.font =[UIFont systemFontOfSize:16];
    titleLable.textColor = UIColorFromRGB(0x000000);
    [bgTitleView addSubview:titleLable];
    return bgTitleView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobScreenDetailCell *cell = (JobScreenDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    
//    if ([self.delegete respondsToSelector:@selector(chooseWord3:cellIndex:tableViewTagIndex:withId:)])
//    {
//        [self.delegete chooseWord3:cell.textLable.text cellIndex:self.cellIndex tableViewTagIndex:self.tableViewTagIndex withId:self.DataArray[indexPath.row][@"id"]];
//    }
    
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[WriteResumeViewController class]])
                {
                    self.delegete = vc;
                    
                    if ([self.delegete respondsToSelector:@selector(chooseWord3:cellIndex:tableViewTagIndex:withId:)])
                    {
                        self.cellIndex = [NSIndexPath indexPathForRow:2 inSection:0];
                        [self.delegete chooseWord3:cell.textLable.text cellIndex:self.cellIndex tableViewTagIndex:self.tableViewTagIndex withId:self.DataArray[indexPath.row][@"id"]];
                    }
                    
                    [self.navigationController popToViewController:vc animated:YES];
    
                    
                }
            }

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
