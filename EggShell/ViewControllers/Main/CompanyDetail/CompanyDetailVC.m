//
//  CompanyDetailVC.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CompanyDetailVC.h"

#import "moreJobTableViewCell.h"

@interface CompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView * backScroll;
    UITableView * _tableView;
    CGRect record_Message;
    CGRect record_SelfView;
    CGRect record_ShowAll;
    CGRect record_tabView;
    
}
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self createScro];
    [self createUI];
  
}
-(void)createScro
{

    UIScrollView  * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:scro];
    self.scro = scro;
}
-(void)createUI
{
    UIView * logoBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 140)];
    logoBackView.backgroundColor = [UIColor whiteColor];
    [self.scro addSubview:logoBackView];
    
    //上部logo
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH / 2 - 50,20, 100, 30)];
    logoView.image = [UIImage imageNamed:@"02"];
    [logoBackView addSubview:logoView];
    
    self.title = @"名企详情";
    self.view.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    self.CMview = [[CompanyMessageView alloc] initWithFrame:CGRectMake(0, 80,WIDETH , 258)];
    self.CMview.showAllClick = ^(UIButton * sender)
    {
        if(!sender.selected)
        {
            [UIView animateWithDuration:0.1 animations:^{
                record_Message = self.CMview.companyMessage.frame;
                record_SelfView = self.CMview.frame;
                record_ShowAll = self.CMview.showAllBtn.frame;
                record_tabView = _tableView.frame;
                self.CMview.frame = CGRectMake(0, self.CMview.frame.origin.y, WIDETH, self.CMview.frame.size.height + self.CMview.textSize.height - 60);
                _tableView.frame = CGRectMake(0, self.CMview.frame.origin.y + self.CMview.frame.size.height + 10, WIDETH, _tableView.frame.size.height);
                self.CMview.showAllBtn.frame = CGRectMake(self.CMview.showAllBtn.origin.x,self.CMview.frame.size.height - 45 , 90, 30);
                self.CMview.companyMessage.frame = CGRectMake(self.CMview.companyMessage.origin.x, self.CMview.companyMessage.origin.y + 8, self.CMview.companyMessage.frame.size.width, self.CMview.textSize.height);
               self.CMview.companyMessage.numberOfLines = 0;
            }];
            
            
        }else
        {
            [UIView animateWithDuration:0.1 animations:^{
                self.CMview.frame = record_SelfView;
                self.CMview.showAllBtn.frame = record_ShowAll;
                self.CMview.companyMessage.frame = record_Message;
                self.CMview.companyMessage.numberOfLines = 5;
                _tableView.frame = record_tabView;
            }];
        }
        sender.selected = !sender.selected;
    };
    self.CMview.backgroundColor = [UIColor whiteColor];
    [self.scro addSubview:self.CMview];
    
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 348, WIDETH,HEIGHT - 348)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.scro addSubview:_tableView];
    self.scro.contentSize = CGSizeMake(WIDETH, 348+_tableView.frame.size.height+100);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    moreJobTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"moreJobTableViewCell" owner:self options:nil] firstObject];
        
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
