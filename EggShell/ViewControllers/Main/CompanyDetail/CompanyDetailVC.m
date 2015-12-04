//
//  CompanyDetailVC.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CompanyDetailVC.h"

#import "moreJobTableViewCell.h"
#import "AFAppRequest.h"
#import "TH_AFRequestState.h"
#import "playFanModel.h"
#import "AFAppRequest.h"
#import "TH_JobDetailVC.h"
#import "findJobModel.h"
#import "TH_LoginVC.h"
@interface CompanyDetailVC ()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>
{
    UITableView * _tableView;
    CGRect record_Message;
    CGRect record_SelfView;
    CGRect record_ShowAll;
    CGRect record_headerView;
    int _page;
    
}
@property(nonatomic,strong)UIView * comPanyView;
@property (nonatomic, strong) MBProgressHUD *mbPro;
@property (strong,nonatomic)AFRequestState * state;
@property(strong,nonatomic)UIImageView * logoView;
@property(nonatomic,strong)NSMutableArray * listArray;
@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self createHeaderView];
    [self createUI];
    

    //    [_header beginRefreshing];
    /*数据请求**/
    _mbPro = [MBProgressHUD mbHubShowControllerView:self];
    _page = 1;
    [self loadData:_mbPro Page:_page];
    
}

-(void)loadData:(id)notify Page:(int)page
{
    if(_state.running)
    {
        return;
    }
    
    NSNumber * pageNum = [NSNumber numberWithInt:page];
    
    
    if (!self.businessMid) {
        self.businessMid = @"";
    }
    if (!self.businessUid) {
        self.businessUid = @"";
    }
    
    NSDictionary * dic = @{@"uid":self.businessUid,@"mid":self.businessMid,@"page":pageNum};
    
    _state = [[TH_AFRequestState famousEnterprisesDetailWithSucc:^(NSDictionary *arr) {
        
        [self.CMview configValue:arr[@"data"][@"details"]];
        if ([arr[@"data"][@"list"] count] >0) {
            [self.listArray addObjectsFromArray:arr[@"data"][@"list"]];
            
        }
        [self.logoView sd_setImageWithURL:[NSURL URLWithString:arr[@"data"][@"details"][@"logo"]] placeholderImage:[UIImage imageNamed:@""]];
        [_tableView reloadData];
    } withd:dic] addNotifaction:notify];
    
}
-(void)createHeaderView
{
    
    self.comPanyView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 355)];
    self.comPanyView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    UIView * logoBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 80)];
//    logoBackView.backgroundColor = [UIColor redColor];
    [self.comPanyView addSubview:logoBackView];
    
    //上部logo
    UIImageView * logoView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDETH -150)/ 2.0 ,15, 150, 50)];
    logoView.image = [UIImage imageNamed:@"logomorentu"];
    self.logoView = logoView;
    [logoBackView addSubview:logoView];
    
    self.title = @"名企详情";
    
    self.CMview = [[CompanyMessageView alloc] initWithFrame:CGRectMake(0, 80,WIDETH , 265)];
    
    self.CMview.showAllClick = ^(UIButton * sender)
    {
    
        
        if(!sender.selected)
        {
            
            
       [UIView animateWithDuration:0.1 animations:^{
           
           
           //
                record_Message = self.CMview.companyMessage.frame;
                
                record_SelfView = self.CMview.frame;
                record_ShowAll = self.CMview.showAllBtn.frame;
                record_headerView = self.comPanyView.frame;

           //详情整个背景视图
           self.CMview.frame = CGRectMake(0, self.CMview.frame.origin.y, WIDETH, self.CMview.frame.size.height + self.CMview.textSize.height - self.CMview.companyMessage.frame.size.height);
            //公司详情视图（包括详情标题，详情lab，展开收起按钮）
           self.comPanyView.frame = CGRectMake(0, self.comPanyView.origin.y, WIDETH, self.comPanyView.height + self.CMview.textSize.height - self.CMview.companyMessage.frame.size.height);
           //展开收起按钮
                self.CMview.showAllBtn.frame = CGRectMake(self.CMview.showAllBtn.origin.x,self.CMview.showAllBtn.frame.origin.y +  self.CMview.textSize.height - self.CMview.companyMessage.frame.size.height, 100, 30);
           //详情lab
                self.CMview.companyMessage.frame = CGRectMake(self.CMview.companyMessage.origin.x, self.CMview.companyMessage.origin.y , self.CMview.companyMessage.frame.size.width, self.CMview.textSize.height);
                self.CMview.companyMessage.numberOfLines = 0;
                _tableView.tableHeaderView = self.comPanyView;
           /*
            Printing description of self->record_Message:
            (CGRect) record_Message = (origin = (x = 15, y = 138), size = (width = 345, height = 80))
            Printing description of self->record_SelfView:
            (CGRect) record_SelfView = (origin = (x = 0, y = 80), size = (width = 375, height = 265))
            Printing description of self->record_ShowAll:
            (CGRect) record_ShowAll = (origin = (x = 137.5, y = 225), size = (width = 100, height = 30))
            Printing description of self->record_headerView:
            (CGRect) record_headerView = (origin = (x = 0, y = 0), size = (width = 375, height = 355))
            **/
           
            }];
            
            
        }else
        {
            [UIView animateWithDuration:0.1 animations:^{
                self.comPanyView.frame = record_headerView;
                self.CMview.frame = record_SelfView;
                self.CMview.showAllBtn.frame = record_ShowAll;
                self.CMview.companyMessage.frame = record_Message;
                self.CMview.companyMessage.numberOfLines = 5;
                _tableView.tableHeaderView = self.comPanyView;
                
            }];
        }
        sender.selected = !sender.selected;
    };
    self.CMview.backgroundColor = [UIColor whiteColor];
    [self.comPanyView addSubview:self.CMview];
    
    //    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 338, WIDETH, 10)];
    //    view.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    //    [self.comPanyView addSubview:view];
}
-(void)createUI
{
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH,HEIGHT - 64)];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = self.comPanyView;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.delegate = self;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView == _header)
    {
        _page = 1;
        [self.listArray removeAllObjects];
        [self loadData:_header Page:_page];
    }else
    {
        _page ++;
        [self loadData:_footer Page:_page];
    }
}
-(void)dealloc
{
    [_header free];
    [_footer free];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSUserDefaults * userId = [NSUserDefaults standardUserDefaults];
//    NSString * userUid  =  [userId objectForKey:@"uid"];
     TH_JobDetailVC * detail = [[TH_JobDetailVC alloc] init];
    detail.uid = [self.listArray[indexPath.row][@"uid"]intValue];
    detail.pid = [self.listArray[indexPath.row][@"id"]intValue];
    
    
    [self.navigationController pushViewController:detail animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    moreJobTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"moreJobTableViewCell" owner:self options:nil] firstObject];
        
    }
    
    if (self.listArray.count > 0) {
        
        
      cell.positionName.text = self.listArray[indexPath.row][@"name"];
        NSString * dateStr = self.listArray[indexPath.row][@"sdate"];
               cell.time.text = [dateStr substringFromIndex:5];
        cell.addres.text = self.listArray[indexPath.row][@"provinceid"];
        cell.companyName.text = self.listArray[indexPath.row][@"com_name"];
    cell.knowdelge.text = self.listArray[indexPath.row][@"edu"];
       cell.salary.text = self.listArray[indexPath.row][@"salary"];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
