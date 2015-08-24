//
//  WriteJLChooseVC.m
//  EggShell
//
//  Created by 太和 on 15/8/21.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteJLChooseVC.h"
#import "JobScreenDetailCell.h"

@interface WriteJLChooseVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView ;
@property(nonatomic,strong)NSArray * DataArray;


@end

@implementation WriteJLChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    
    [self qureData];
    
    [self createTableView];
    
    [self createjobBtn];
}

- (void)qureData
{
    self.DataArray = @[@"计算机/互联网",@"技术人员/助理",@"北京",@"3000-10000",@"本科",@"3年",@"全职",@"一天内"];
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
    cell.textLable.text = self.DataArray[indexPath.row];
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
    if ([self.delegete respondsToSelector:@selector(chooseWord:cellIndex:tableViewTagIndex:)])
    {
        [self.delegete chooseWord:cell.textLable.text cellIndex:self.cellIndex tableViewTagIndex:self.tableViewTagIndex];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
