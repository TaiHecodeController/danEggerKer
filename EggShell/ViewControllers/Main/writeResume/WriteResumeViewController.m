//
//  WriteResumeViewController.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteResumeViewController.h"
#import "WriteResumeCell.h"
#import "ExceptCityCell.h"
#import "NameAndSexCell.h"
#import "WriteResumeVC2.h"

@interface WriteResumeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * jobTableView;
    UITableView * userTableView;
    
}
@property (strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property (strong,nonatomic)NSMutableArray * jobCellArray;

@property (strong,nonatomic)NSArray * nameArray2;
@property (strong,nonatomic)NSArray * holderArray2;
@property (strong,nonatomic)NSMutableArray * jobCellArray2;


@end

@implementation WriteResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写简历";
    self.jobCellArray = [NSMutableArray arrayWithCapacity:0];
    self.jobCellArray2 = [NSMutableArray arrayWithCapacity:0];
    [self createData];
    [self createUI];

    // Do any additional setup after loading the view.
}

-(void)createData
{
    self.nameArray = @[@"简历名称",@"从事行业",@"期望职位",@"期望薪资",@"期望城市",@"工作性质",@"到岗时间",@"求职状态"];
    self.holderArray = @[@"请填写您的简历名称",@"请选择您的从事行业",@"请选择您的期望职位",@"请选择您的期望薪资",@"",@"请选择您的工作性质",@"请选择您的到岗时间",@"请选择您的求职状态"];
    self.nameArray2 = @[@"",@"出生年月",@"最高学历",@"工作经验",@"手机号码",@"联系邮箱",@"现居住地"];
    self.holderArray2 = @[@"",@"请填写您的出生年月",@"请填写您的最高学历",@"请填写您的工作经验",@"请填写您的手机号码",@"请填写您的联系邮箱",@"请填写您的现居住地"];
    
}

-(void)createUI
{
    //最底层ScrollView
    UIScrollView *back_sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    back_sv.contentSize = CGSizeMake(WIDETH, 754 + 64);
    back_sv.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    [self.view addSubview:back_sv];
    [back_sv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    
    UILabel * startLab = [ZCControl createLabelWithFrame:CGRectMake(15, 10, WIDETH / 1.5, 20) Font:12 Text:@"好的简历能帮助你更快的找到好工作!"];
    [back_sv addSubview:startLab];
    
    UIButton * mustWrite = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 1.5 + 5, 9.5, 53, 23) ImageName:@"hongniu2" Target:self Action:@selector(mustClick) Title:@"必填"];
    [mustWrite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mustWrite.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [back_sv addSubview:mustWrite];
    
    //中间tabelview
    jobTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, WIDETH, 336)];
    jobTableView.delegate = self;
    jobTableView.dataSource = self;
    jobTableView.scrollEnabled = NO;
    jobTableView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    jobTableView.layer.borderWidth = 0.5;
    jobTableView.tag = 1555;
    [back_sv addSubview:jobTableView];
    
    //下方tableView
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 399, WIDETH, 294)];
    userTableView.delegate = self;
    userTableView.dataSource = self;
    userTableView.scrollEnabled = NO;
    userTableView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    userTableView.layer.borderWidth = 0.5;
    userTableView.tag = 1999;
    [back_sv addSubview:userTableView];
    
    //保存按钮
   UIButton * nextBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 2 - 75, 709, 150, 30) ImageName:@"lanniu2" Target:self Action:@selector(nextClick) Title:@"保存"];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [back_sv addSubview:nextBtn];
    
}

-(void)nextClick
{
//    for(int i = 0;i < self.jobCellArray.count;i++)
//    {
//        if(i==4)
//        {
//            continue;
//        }else
//        {
//            WriteResumeCell * cell = self.jobCellArray[i];
//            NSLog(@"%@",cell.contentTextField.text);
//        }
//        
//    }
//    
//    for(int i = 0;i < self.jobCellArray2.count;i++)
//    {
//        if(i==0)
//        {
//            continue;
//        }else
//        {
//            WriteResumeCell * cell = self.jobCellArray[i];
//            NSLog(@"%@",cell.contentTextField.text);
//        }
//        
//    }
    WriteResumeVC2 * wrvc2 = [[WriteResumeVC2 alloc] init];
    [self.navigationController pushViewController:wrvc2 animated:YES];
    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1555)
    {
        return 8;
    }
    return 7;
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, WIDETH, HEIGHT, 100)];

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1555)
    {
        if(indexPath.row != 4)
        {
            WriteResumeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
            if(!cell)
            {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"WriteResumeCell" owner:self options:nil] firstObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.resumeName.text = self.nameArray[indexPath.row];
            cell.contentTextField.placeholder = self.holderArray[indexPath.row];
            cell.showMessageBtn.tag = 100 + indexPath.row;
            if(indexPath.row == 0)
            {
                cell.showMessageBtn.hidden = YES;
            }
            [self.jobCellArray addObject:cell];
            return cell;
            
        }else
        {
            ExceptCityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ExceptCityCell" owner:self options:nil] firstObject];
            }
            [self.jobCellArray addObject:cell];
            return cell;
        }

    }else
    {
        if(indexPath.row == 0)
        {
            NameAndSexCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NameAndSexCell" owner:self options:nil] firstObject];
            }
            [self.jobCellArray2 addObject:cell];
            return cell;
        }else
        {
            WriteResumeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"WriteResumeCell" owner:self options:nil] firstObject];
            }
            cell.resumeName.text = self.nameArray2[indexPath.row];
            cell.contentTextField.placeholder = self.holderArray2[indexPath.row];
            [self.jobCellArray2 addObject:cell];
            return cell;
        }
    }
    
    

    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(void)mustClick
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
