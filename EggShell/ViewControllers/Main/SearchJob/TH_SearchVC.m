//
//  TH_SearchVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/19.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_SearchVC.h"
#import "HeadView.h"
#import "HotSearch.h"
#import "DataBase.h"
@interface TH_SearchVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    HeadView * headView;
    HotSearch * hotSearch;
}
@property (strong,nonatomic)NSMutableArray * dataArray;
@property (strong,nonatomic)DataBase * db;


@end

@implementation TH_SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"职位搜索";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self loadData];
    [self crateUI];
    // Do any additional setup after loading the view.
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
    headView = [[[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:self options:nil] firstObject];
    headView.frame = CGRectMake(0, 0, WIDETH, 70-64);
    headView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headView];

    headView.searchClick = ^(NSString * text)
    {
        [self.db insertDB:text];
        [self loadData];
        [_tableView reloadData];
    };
    
//    hotSearch = [[[NSBundle mainBundle] loadNibNamed:@"HotSearch" owner:self options:nil] firstObject];
//    hotSearch.frame = CGRectMake(0, 150, WIDETH, 149);
//    [self.view addSubview:hotSearch];
    
//    [self createTableView];
    
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, hotSearch.frame.origin.y + hotSearch.frame.size.height, WIDETH, HEIGHT / 3)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [headView.seachText endEditing:YES];
}

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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    if(indexPath.row == 0)
    {
        cell.textLabel.text = @"搜索历史";
        cell.textLabel.textColor = [UIColor colorWithRed:122 / 255.0 green:122 / 255.0 blue:122 / 255.0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }else if(self.dataArray.count != 0)
    {
        
        cell.textLabel.text = self.dataArray[indexPath.row - 1];
        cell.textLabel.textColor = [UIColor colorWithRed:57 / 255.0 green:57 / 255.0 blue:57 / 255.0 alpha:1];
    }
    return cell;
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
