//
//  TH_SearchJobVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/26.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_SearchJobVC.h"
#import "HeadView.h"
#import "HotSearch.h"
#import "DataBase.h"
#import "TH_FindJobVC.h"
#import "TH_AFRequestState.h"
#import "SearchModelShare.h"

#define headViewHeight 58
#define hotSearchHeight 149

@interface TH_SearchJobVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    HeadView * headView;
    HotSearch * hotSearch;
}
@property (strong,nonatomic)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableViewCell * cell;
@property (strong,nonatomic)DataBase * db;

@end

@implementation TH_SearchJobVC

- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"职位搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
    [self crateUI];
}


-(void)loadData
{
    self.db = [DataBase shareDB];
    if(self.db)
    {
        self.dataArray = [self.db selectFromDB];
    }
}

-(void)crateUI
{
    UIView * headBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 58+149)];
    [self.view addSubview:headBgView];
    headView = [[[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:self options:nil] lastObject];
    headView.frame = CGRectMake(0, 0, WIDETH, 58);
    [headBgView addSubview:headView];
    __weak typeof(self) weakSelf = self;
    headView.searchClick = ^(NSString * text)
    {
        if(![text isEqualToString:@""])
        {
            [weakSelf.db insertDB:text];
            [weakSelf loadData];
            [_tableView reloadData];
        }
        
        //        [SearchModelShare sharedInstance].keyword = text;
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"keyWord" object:nil];
        
        if (_pushType == 0)
        {
            //从首页来的，跳到职位列表页
            TH_FindJobVC *vc = [[TH_FindJobVC alloc]init];
            //            vc.title = @"搜索结果";
            //            vc.rk_pushType = homePushType;
            vc.keyword = text;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            //从职位列表来，返回职位列表
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        
    };
    
    hotSearch = [[[NSBundle mainBundle] loadNibNamed:@"HotSearch" owner:self options:nil] lastObject];
    hotSearch.frame = CGRectMake(0,headViewHeight , WIDETH, 149);
    [headBgView addSubview:hotSearch];
        for (UIButton *btn in hotSearch.subviews)
    {
        if ([btn isKindOfClass:[UIButton class]])
        {
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [self createTableView];
    
}

- (void)btnClick:(UIButton *)sender
{
    TH_FindJobVC *vc = [[TH_FindJobVC alloc]init];
    
    //    NSLog(@"%@",sender.titleLabel.text);
    
    if ([sender.titleLabel.text isEqual:@"银行柜员"])
    {
        //        [SearchModelShare sharedInstance].keyword = @"柜员";
        vc.keyword = @"柜员";
        [self.navigationController pushViewController:vc animated:YES];
        [self.db insertDB:@"柜员"];
    }
    else
    {
        //        [SearchModelShare sharedInstance].type = @"";
        //        [SearchModelShare sharedInstance].keyword = sender.titleLabel.text;
        vc.keyword = sender.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
        [self.db insertDB:sender.titleLabel.text];
    }
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyWord" object:nil];
    
    if (_pushType == 0)
    {
        //从首页来的，跳到职位列表页
        
        //        vc.title  = @"搜索结果";
        //        vc.rk_pushType = homePushType;
    }
    else
    {
        //从职位列表来，返回职位列表
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  hotSearchHeight + headViewHeight , WIDETH, HEIGHT - hotSearchHeight - headViewHeight -64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView =[[UIView alloc] init];
    [self.view addSubview:_tableView];
}



//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [headView.seachText endEditing:YES];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row == 0)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"搜索历史";
        cell.textLabel.textColor = [UIColor colorWithRed:122 / 255.0 green:122 / 255.0 blue:122 / 255.0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    else if(self.dataArray.count != 0)
    {
        
        cell.textLabel.text = self.dataArray[indexPath.row - 1];
        cell.textLabel.textColor = [UIColor colorWithRed:57 / 255.0 green:57 / 255.0 blue:57 / 255.0 alpha:1];
    }
    self.cell = cell;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return;
    }
    else
    {
        
        TH_FindJobVC *vc = [[TH_FindJobVC alloc]init];
        vc.keyword = self.dataArray[indexPath.row - 1];
        //    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyWord" object:nil];
        
        //    if (_pushType == 0)
        //    {
        //从首页来的，跳到职位列表页
        //        vc.rk_pushType = homePushType;
        [self.navigationController pushViewController:vc animated:YES];
        //    }
        //    else
        //    {
        //        //从职位列表来，返回职位列表
        //        [self.navigationController popViewControllerAnimated:YES];
        //    }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
   
//    [MobClick beginLogPageView:@"searchjobvc"];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [MobClick endLogPageView:@"searchjobvc"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
