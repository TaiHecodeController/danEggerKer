
//
//  TH_ReceiveResumeVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//
/*
 收到简历
 *
 */
#import "TH_ReceiveResumeVC.h"
#import "TableViewCell_1.h"
#import "TableViewCell_2.h"
#import "TableViewCell_3.h"
#import "TableViewCell_4.h"
#import "MJRefresh.h"
#import "enterPriseRequest.h"
#import "cpy_ReciveResumeListMode.h"
#import "TH_ResumePreviewVC.h"
#define bottomHeight 48
//每页显示的条数
#define pageNum 10

@interface TH_ReceiveResumeVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MBProgressHUD * _mbPro;
}

//顶部四个按钮
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;

//未查看，已查看，待通知，不合适，四个列表
@property (nonatomic, strong) UITableView *tableview_1;
@property (nonatomic, strong) UITableView *tableview_2;
@property (nonatomic, strong) UITableView *tableview_3;
@property (nonatomic, strong) UITableView *tableview_4;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *deletBtn;
@property (nonatomic, strong) UIButton *kuangIcon;
@property (nonatomic, strong) UILabel *allSelLab;

@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property (nonatomic) int page;
@property (nonatomic,strong)AFRequestState * state;

@property (nonatomic, strong) NSMutableArray *resumeList;
@property (nonatomic) int tableViewTag;

//删除简历保存eid和job_id参数的连个字符串
@property (nonatomic, copy) NSString *eid_str;
@property (nonatomic, copy) NSString *jobid_str;

@end

@implementation TH_ReceiveResumeVC

-(void)dealloc
{
        
    [_header free];
    [_footer free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resumeList = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = color(240, 240, 237);
    
    self.title = @"收到简历";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yichakan:) name:@"yichakan" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(daitongzhi:) name:@"daitongzhi" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buheshi:) name:@"buheshi" object:nil];
    
    [self addTopBtn];
    
    int btnHeight = 40;
    
    _tableview_1 = [[UITableView alloc] init];
    _tableview_1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_1.frame = CGRectMake(0, btnHeight, WIDETH, HEIGHT - bottomHeight - 20 -44 - btnHeight);
    [self.view addSubview:_tableview_1];
    _tableview_1.backgroundColor = [UIColor clearColor];
    _tableview_1.tag = 1001;
    _tableview_1.dataSource = self;
    _tableview_1.delegate = self;
    _tableview_1.hidden = NO;
    
    _tableViewTag = _tableview_1.tag;
    
    _tableview_2 = [[UITableView alloc] init];
    _tableview_2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_2.frame = CGRectMake(0, btnHeight, WIDETH, HEIGHT - bottomHeight - 20 -44 - btnHeight);
    [self.view addSubview:_tableview_2];
    _tableview_2.backgroundColor = [UIColor clearColor];
    _tableview_2.tag = 1002;
    _tableview_2.hidden = YES;
    
    _tableview_3 = [[UITableView alloc] init];
    _tableview_3.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_3.frame = CGRectMake(0, btnHeight, WIDETH, HEIGHT - bottomHeight - 20 -44 - btnHeight);
    [self.view addSubview:_tableview_3];
    _tableview_3.backgroundColor = [UIColor clearColor];
    _tableview_3.tag = 1003;
//    _tableview_3.dataSource = self;
//    _tableview_3.delegate = self;
    _tableview_3.hidden = YES;
    
    _tableview_4 = [[UITableView alloc] init];
    _tableview_4.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_4.frame = CGRectMake(0, btnHeight, WIDETH, HEIGHT - bottomHeight - 20 -44 - btnHeight);
    [self.view addSubview:_tableview_4];
    _tableview_4.backgroundColor = [UIColor clearColor];
    _tableview_4.tag = 1004;
//    _tableview_4.dataSource = self;
//    _tableview_4.delegate = self;
    _tableview_4.hidden = YES;
    
    [self addBottomView];
    
    [self querData];
}

- (void)querData
{
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    //上拉刷新
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    
    _mbPro = [MBProgressHUD mbHubShow];
    _page = 1;
    [self querDataWithNoti:_mbPro uid:@"72" browse:1 pageIndex:_page page:pageNum];
}

- (void)querDataWithNoti:(id)noti uid:(NSString *)uid browse:(int)browse pageIndex:(int)pageIndex page:(int)page
{
    
//    if(_state.running)
//    {
//        return;
//    }
    
   self.state =  [[enterPriseRequest requestWithSucc:^(NSArray *DataDic) {
       
       NSLog(@"简历列表：%@",DataDic);
       
       if (DataDic.count > 0)
       {
           if (_tableViewTag == 1001)
           {
               [self.resumeList addObjectsFromArray:DataDic];
               [_tableview_1 reloadData];

           }
           else if (_tableViewTag == 1002)
           {
               [self.resumeList addObjectsFromArray:DataDic];
               [_tableview_2 reloadData];

           }
           else if (_tableViewTag == 1003)
           {
               [self.resumeList addObjectsFromArray:DataDic];
               [_tableview_3 reloadData];

           }
           else
           {
               [self.resumeList addObjectsFromArray:DataDic];
               [_tableview_4 reloadData];

           }
       }
       
    } uid:uid is_browse:browse pageIndex:pageIndex page:page resp:[cpy_ReciveResumeListMode class]] addNotifaction:noti];
}

- (void)addBottomView
{
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.frame = CGRectMake(0, HEIGHT - 20 - 44 - bottomHeight * MyWideth, WIDETH , bottomHeight * MyWideth);
    [self.view addSubview:_bottomView];
    
    _deletBtn = [[UIButton alloc]init];
    [_deletBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deletBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deletBtn setBackgroundColor:[UIColor redColor]];
    _deletBtn.frame = CGRectMake((WIDETH - 195 * MyWideth) / 2, 9, 195 * MyWideth, 30 * MyWideth);
    [_deletBtn addTarget:self action:@selector(deletBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_deletBtn];
    
    _kuangIcon = [[UIButton alloc]init];
    _kuangIcon.frame = CGRectMake(10, 5, 37 * MyWideth, 37 * MyWideth);
    [_kuangIcon setBackgroundImage:[UIImage imageNamed:@"duikuang001"] forState:UIControlStateNormal];
    [_kuangIcon setBackgroundImage:[UIImage imageNamed:@"duikuang123"] forState:UIControlStateSelected];
    [_kuangIcon addTarget:self action:@selector(all_Click:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_kuangIcon];
    
    _allSelLab = [[UILabel alloc]init];
    _allSelLab.text = @"全选";
    _allSelLab.font = [UIFont systemFontOfSize:13 * MyWideth];
    CGSize allSelSize = [_allSelLab.text sizeWithFont:_allSelLab.font];
    _allSelLab.frame = CGRectMake(CGRectGetMaxX(_kuangIcon.frame), 17.5, allSelSize.width, allSelSize.height);
    [_bottomView addSubview:_allSelLab];

}

- (void)allClick:(UIButton *)btn
{
    if (btn.selected == NO)
    {
        btn.selected = YES;
    }
    else
    {
        btn.selected = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger romNum;
    if (tableView.tag == 1001)
    {
        romNum = _resumeList.count;
    }
    else if (tableView.tag == 1002)
    {
        romNum = _resumeList.count;
    }
    else if (tableView.tag == 1003)
    {
        romNum = _resumeList.count;
    }
    else
    {
        romNum = _resumeList.count;
    }
    return romNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tag:%ld",(long)tableView.tag);
    
        if (tableView.tag == 1001)
        {
            static NSString *str = @"identifile_1";
            TableViewCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil)
            {
                cell = [[TableViewCell_1 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            }
            if(self.resumeList.count >0)
            {
                cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
                [cell config:model];
                cell.icon_seleted = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
                [cell.selIcon addTarget:self action:@selector(singleClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell layoutSubviews];
            }
            
            return cell;
        }
        else if (tableView.tag == 1002)
        {
            static NSString *str = @"identifile_2";
            TableViewCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil)
            {
                cell = [[TableViewCell_2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            }
            if(self.resumeList.count >0)
            {
                cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
                [cell config:model];
                cell.icon_seleted = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
                [cell.selIcon addTarget:self action:@selector(singleClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell layoutSubviews];
            }

            return cell;
        }
        else if (tableView.tag == 1003)
        {
            static NSString *str = @"identifile_3";
            TableViewCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil)
            {
                cell = [[TableViewCell_3 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            }
            if(self.resumeList.count >0)
            {
                cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
                [cell config:model];
                cell.icon_seleted = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
                [cell.selIcon addTarget:self action:@selector(singleClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell layoutSubviews];
            }
            
            return cell;
        }
        else
        {
            static NSString *str = @"identifile_4";
            TableViewCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil)
            {
                cell = [[TableViewCell_4 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            }
            if(self.resumeList.count >0)
            {
                cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
                [cell config:model];
                cell.icon_seleted = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
                [cell.selIcon addTarget:self action:@selector(singleClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell layoutSubviews];
            }
            
            return cell;
        }

    

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];

    
    TH_ResumePreviewVC  * presum = [[TH_ResumePreviewVC alloc] init];
//    presum.title = @"简历预览";
    presum.resumeId = model.eid;
//    presum.resumeName = self.ResumeName.text;
    [self.navigationController pushViewController:presum animated:YES];
    
    
    
}

- (void)addTopBtn
{
    _btn1 = [[UIButton alloc] init];
    int Btnwidth = WIDETH / 4;
    _btn1.frame = CGRectMake(0, 0, Btnwidth, 40);
    //    _btn1.backgroundColor = [UIColor blueColor];
    [_btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [_btn1 setTitle:@"未查看" forState:UIControlStateNormal];
    [_btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:13 * MyWideth];
    [self.view addSubview:_btn1];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = color(215, 215, 215);
    line1.frame = CGRectMake(CGRectGetMaxX(_btn1.frame) - 0.5, 13, 1, 13);
    [self.view addSubview:line1];
    
    _btn2 = [[UIButton alloc] init];
    _btn2.frame = CGRectMake(CGRectGetMaxX(_btn1.frame), 0, Btnwidth, 40);
    //    _btn2.backgroundColor = [UIColor blueColor];
    [_btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 setTitle:@"已查看" forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     _btn2.titleLabel.font = [UIFont systemFontOfSize:13 * MyWideth];
    [self.view addSubview:_btn2];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = color(215, 215, 215);
    line2.frame = CGRectMake(CGRectGetMaxX(_btn2.frame) - 0.5, 13, 1, 13);
    [self.view addSubview:line2];
    
    _btn3 = [[UIButton alloc] init];
    _btn3.frame = CGRectMake(CGRectGetMaxX(_btn2.frame), 0, Btnwidth, 40);
    //    _btn3.backgroundColor = [UIColor blueColor];
    [_btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 setTitle:@"待通知" forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     _btn3.titleLabel.font = [UIFont systemFontOfSize:13 * MyWideth];
    [self.view addSubview:_btn3];
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = color(215, 215, 215);
    line3.frame = CGRectMake(CGRectGetMaxX(_btn3.frame) - 0.5, 13, 1, 13);
    [self.view addSubview:line3];
    
    _btn4 = [[UIButton alloc] init];
    _btn4.frame = CGRectMake(CGRectGetMaxX(_btn3.frame), 0, Btnwidth, 40);
    //    _btn4.backgroundColor = [UIColor blueColor];
    [_btn4 addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
    [_btn4 setTitle:@"不合适" forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     _btn4.titleLabel.font = [UIFont systemFontOfSize:13 * MyWideth];
    [self.view addSubview:_btn4];
}

- (void)btn1Click
{
     [_btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
     [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [_btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _tableview_1.hidden = NO;
    _tableview_2.hidden = YES;
    _tableview_3.hidden = YES;
    _tableview_4.hidden = YES;
    
    _tableview_1.dataSource = self;
    _tableview_1.delegate = self;
    
    _header.scrollView = _tableview_1;
    _footer.scrollView = _tableview_1;
    
    _page = 1;
    _tableViewTag = 1001;
    [self.resumeList removeAllObjects];
    [self querDataWithNoti:_mbPro uid:@"72" browse:1 pageIndex:_page page:pageNum];
    
}

- (void)btn2Click
{
    [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _tableview_1.hidden = YES;
    _tableview_2.hidden = NO;
    _tableview_3.hidden = YES;
    _tableview_4.hidden = YES;
    
    _tableview_2.dataSource = self;
    _tableview_2.delegate = self;

    _header.scrollView = _tableview_2;
    _footer.scrollView = _tableview_2;
    
    _page = 1;
    _tableViewTag = 1002;
    [self.resumeList removeAllObjects];
    [self querDataWithNoti:_mbPro uid:@"72" browse:2 pageIndex:_page page:pageNum];

}

- (void)btn3Click
{
    [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _tableview_1.hidden = YES;
    _tableview_2.hidden = YES;
    _tableview_3.hidden = NO;
    _tableview_4.hidden = YES;
    
    _tableview_3.dataSource = self;
    _tableview_3.delegate = self;

    _header.scrollView = _tableview_3;
    _footer.scrollView = _tableview_3;
    
    _page = 1;
    _tableViewTag = 1003;
    [self.resumeList removeAllObjects];
    [self querDataWithNoti:_mbPro uid:@"72" browse:3 pageIndex:_page page:pageNum];

}

- (void)btn4Click
{
    [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _tableview_1.hidden = YES;
    _tableview_2.hidden = YES;
    _tableview_3.hidden = YES;
    _tableview_4.hidden = NO;
    
    _tableview_4.dataSource = self;
    _tableview_4.delegate = self;
    
    _header.scrollView = _tableview_4;
    _footer.scrollView = _tableview_4;
    
    _page = 1;
    _tableViewTag = 1004;
    [self.resumeList removeAllObjects];
    [self querDataWithNoti:_mbPro uid:@"72" browse:4 pageIndex:_page page:pageNum];

}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 1;
        [self.resumeList removeAllObjects];
        if (_tableViewTag == 1001)
        {
           [self querDataWithNoti:refreshView uid:@"72" browse:1 pageIndex:_page page:pageNum];
            
        }
        else if (_tableViewTag == 1002)
        {
            
            [self querDataWithNoti:refreshView uid:@"72" browse:2 pageIndex:_page page:pageNum];
        }
        else if (_tableViewTag == 1003)
        {
            [self querDataWithNoti:refreshView uid:@"72" browse:3 pageIndex:_page page:pageNum];
        }
        else
        {
            [self querDataWithNoti:refreshView uid:@"72" browse:4 pageIndex:_page page:pageNum];
        }
        
    }
    else{

        _page++;
        if (_tableViewTag == 1001)
        {
            [self querDataWithNoti:refreshView uid:@"72" browse:1 pageIndex:_page page:pageNum];
            
        }
        else if (_tableViewTag == 1002)
        {
            
            [self querDataWithNoti:refreshView uid:@"72" browse:2 pageIndex:_page page:pageNum];
        }
        else if (_tableViewTag == 1003)
        {
            [self querDataWithNoti:refreshView uid:@"72" browse:3 pageIndex:_page page:pageNum];
        }
        else
        {
            [self querDataWithNoti:refreshView uid:@"72" browse:4 pageIndex:_page page:pageNum];
        }

    }
}


#pragma mark -- notification
//已查看
- (void)yichakan:(NSNotification *)noti
{
    
    if (_tableViewTag == 1001)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_1 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        THLog(@" %@ %@",model.eid,model.job_id);
        self.state = [[enterPriseRequest requestWithSucc:^(NSDictionary *DataDic) {
            
//            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:1 pageIndex:_page page:pageNum];
                
            }
            
            
        } eid:[model.eid  intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];

    }
    else if (_tableViewTag == 1002)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_1 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestWithSucc:^(NSDictionary *DataDic) {
            
//            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:2 pageIndex:_page page:pageNum];
                
            }
            
        } eid:[model.eid intValue] job_id:[model.job_id intValue]com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];

    }
    else if (_tableViewTag == 1003)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_1 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestWithSucc:^(NSDictionary *DataDic) {
            
//            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:3 pageIndex:_page page:pageNum];
                
            }

            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];

    }
    else
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_1 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestWithSucc:^(NSDictionary *DataDic) {
            
//            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:4 pageIndex:_page page:pageNum];
                
            }

            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];

    }


    
    
    
}

//待通知
- (void)daitongzhi:(NSNotification *)noti
{
    NSLog(@"待通知");
    if (_tableViewTag == 1001)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_1 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestWillNotifWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:1 pageIndex:_page page:pageNum];
                
            }

            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];
        
    }
    else if (_tableViewTag == 1002)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_2 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_2 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        NSLog(@"%@ %@",model.eid,model.job_id);
        self.state = [[enterPriseRequest requestWillNotifWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:2 pageIndex:_page page:pageNum];
                
            }

            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];
    }
    else if (_tableViewTag == 1003)
    {
       
        NSDictionary *dic = [noti userInfo];
        TableViewCell_3 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_3 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestWillNotifWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:3 pageIndex:_page page:pageNum];
                
            }

            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];
    }
    else
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_4 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_4 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestWillNotifWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:4 pageIndex:_page page:pageNum];
                
            }

        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];
    }

}

//不合适
- (void)buheshi:(NSNotification *)noti
{
    THLog(@"不合适");
    if (_tableViewTag == 1001)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_1 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestUnadptedWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:1 pageIndex:_page page:pageNum];
                
            }

            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];
        
    }
    else if (_tableViewTag == 1002)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_2 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_2 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestUnadptedWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:2 pageIndex:_page page:pageNum];
                
            }

            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];

        
    }
    else if (_tableViewTag == 1003)
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_3 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_3 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestUnadptedWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:3 pageIndex:_page page:pageNum];
                
            }
            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];

    }
    else
    {
        NSDictionary *dic = [noti userInfo];
        TableViewCell_4 *cell = dic[@"cellSelf"];
        NSIndexPath *indexPath =  [_tableview_4 indexPathForCell:cell];
        cpy_ReciveResumeListMode *model = self.resumeList[indexPath.row];
        self.state = [[enterPriseRequest requestUnadptedWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"修改成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:4 pageIndex:_page page:pageNum];
                
            }
            
        } eid:[model.eid intValue] job_id:[model.job_id intValue] com_id:72] addNotifaction:[MBProgressHUD mbHubShow]];
    
    }

    
}

#pragma mark -- respondEvent
- (void)all_Click:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        //选中所有
        for (int i = 0; i< self.resumeList.count; i++) {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            cpy_ReciveResumeListMode *model = self.resumeList[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"1";
        }
        
        if (_tableViewTag == 1001)
        {
            [_tableview_1 reloadData];
        }
        else if (_tableViewTag == 1002)
        {
            [_tableview_2 reloadData];
        }
        else if (_tableViewTag == 1003)
        {
            [_tableview_3 reloadData];
        }
        else
        {
            [_tableview_4 reloadData];
        }
        
        
        
    }
    else
    {
        sender.selected = NO;
        //失选所有
        for (int i = 0; i < self.resumeList.count; i++)
        {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            cpy_ReciveResumeListMode *model = self.resumeList[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"0";
        }
        if (_tableViewTag == 1001)
        {
            [_tableview_1 reloadData];
        }
        else if (_tableViewTag == 1002)
        {
            [_tableview_2 reloadData];
        }
        else if (_tableViewTag == 1003)
        {
            [_tableview_3 reloadData];
        }
        else
        {
            [_tableview_4 reloadData];
        }

    }
}

- (void)singleClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        
        TableViewCell_1 *cell = (TableViewCell_1 *)[sender superview];
        NSIndexPath *indexPath = [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *fjModel = self.resumeList[indexPath.row];
        fjModel.cellselected = @"1";
        
    }
    else
    {
        sender.selected = NO;
        
        TableViewCell_1 *cell = (TableViewCell_1 *)[sender superview];
        NSIndexPath *indexPath = [_tableview_1 indexPathForCell:cell];
        cpy_ReciveResumeListMode *fjModel = self.resumeList[indexPath.row];
        fjModel.cellselected = @"0";
    }
    
}

#pragma mark -- 删除简历按钮
- (void)deletBtnClick
{
    
    //去所有eid
    NSMutableString *eidstr = [[NSMutableString alloc]init];
    for (cpy_ReciveResumeListMode *model in self.resumeList)
    {
        if ([model.cellselected isEqualToString: @"1"])
        {
            [eidstr appendString:[NSString stringWithFormat:@"%@,",model.eid]];
            
        }
        
    }
    NSLog(@"eidstr%@",eidstr);
    //取所有job_id
    NSMutableString *jobidstr = [[NSMutableString alloc]init];
    for (cpy_ReciveResumeListMode *model in self.resumeList)
    {
        if ([model.cellselected isEqualToString: @"1"])
        {
            [jobidstr appendString:[NSString stringWithFormat:@"%@,",model.job_id]];
            
        }
        
    }
    NSLog(@"eidstr%@",jobidstr);

    
    if (_tableViewTag == 1001)
    {
        
        [[enterPriseRequest requestDeletResumeWithSucc:^(NSDictionary *DataDic) {
            
            //        NSLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"删除成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:1 pageIndex:_page page:pageNum];
                
            }
            
        } eid:eidstr job_id:jobidstr com_id:72] addNotifaction:_mbPro];
    }
    else if (_tableViewTag == 1002)
    {
        
        [[enterPriseRequest requestDeletResumeWithSucc:^(NSDictionary *DataDic) {
            
            //        NSLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"删除成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:2 pageIndex:_page page:pageNum];
                
            }
            
        } eid:eidstr job_id:jobidstr com_id:72] addNotifaction:_mbPro];
    }
    else if (_tableViewTag == 1003)
    {
        
        
        [[enterPriseRequest requestDeletResumeWithSucc:^(NSDictionary *DataDic) {
            
            //        NSLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"删除成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:3 pageIndex:_page page:pageNum];
                
            }
            
        } eid:eidstr job_id:jobidstr com_id:72] addNotifaction:_mbPro];
    }
    else
    {
        
        [[enterPriseRequest requestDeletResumeWithSucc:^(NSDictionary *DataDic) {
            
            //        NSLog(@"%@",DataDic);
            if ([DataDic[@"code"] intValue] == 0)
            {
                [MBProgressHUD creatembHub:@"删除成功"];
                
                _page = 1;
                [self.resumeList removeAllObjects];
                [self querDataWithNoti:_mbPro uid:@"72" browse:4 pageIndex:_page page:pageNum];
                
            }
            
        } eid:eidstr job_id:jobidstr com_id:72] addNotifaction:_mbPro];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
