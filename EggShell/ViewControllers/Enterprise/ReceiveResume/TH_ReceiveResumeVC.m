
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


#define bottomHeight 48

@interface TH_ReceiveResumeVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
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

@end

@implementation TH_ReceiveResumeVC

-(void)dealloc
{
        
    [_header free];
    [_footer free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = color(240, 240, 237);
    
    self.title = @"收到简历";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yichakan) name:@"yichakan" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(daitongzhi) name:@"daitongzhi" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buheshi) name:@"buheshi" object:nil];
    
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
    
    _tableview_2 = [[UITableView alloc] init];
    _tableview_2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_2.frame = CGRectMake(0, btnHeight, WIDETH, HEIGHT - bottomHeight - 20 -44 - btnHeight);
    [self.view addSubview:_tableview_2];
    _tableview_2.backgroundColor = [UIColor clearColor];
    _tableview_2.tag = 1002;
    _tableview_2.dataSource = self;
    _tableview_2.delegate = self;
    _tableview_2.hidden = YES;
    
    _tableview_3 = [[UITableView alloc] init];
    _tableview_3.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_3.frame = CGRectMake(0, btnHeight, WIDETH, HEIGHT - bottomHeight - 20 -44 - btnHeight);
    [self.view addSubview:_tableview_3];
    _tableview_3.backgroundColor = [UIColor clearColor];
    _tableview_3.tag = 1003;
    _tableview_3.dataSource = self;
    _tableview_3.delegate = self;
    _tableview_3.hidden = YES;
    
    _tableview_4 = [[UITableView alloc] init];
    _tableview_4.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_4.frame = CGRectMake(0, btnHeight, WIDETH, HEIGHT - bottomHeight - 20 -44 - btnHeight);
    [self.view addSubview:_tableview_4];
    _tableview_4.backgroundColor = [UIColor clearColor];
    _tableview_4.tag = 1004;
    _tableview_4.dataSource = self;
    _tableview_4.delegate = self;
    _tableview_4.hidden = YES;
    
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    //上拉刷新
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;

    [self addBottomView];
}

- (void)addBottomView
{
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    _bottomView.frame = CGRectMake(0, HEIGHT - 20 - 44 - bottomHeight, WIDETH , bottomHeight * MyWideth);
    [self.view addSubview:_bottomView];
    
    _deletBtn = [[UIButton alloc]init];
    [_deletBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deletBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deletBtn setBackgroundColor:[UIColor redColor]];
    _deletBtn.frame = CGRectMake((WIDETH - 195) / 2, 9, 195 * MyWideth, 30 * MyWideth);
    [_bottomView addSubview:_deletBtn];
    
    _kuangIcon = [[UIButton alloc]init];
    _kuangIcon.frame = CGRectMake(10, 5, 37 * MyWideth, 37 * MyWideth);
    [_kuangIcon setBackgroundImage:[UIImage imageNamed:@"duikuang001"] forState:UIControlStateNormal];
    [_kuangIcon setBackgroundImage:[UIImage imageNamed:@"duikuang123"] forState:UIControlStateSelected];
    [_kuangIcon addTarget:self action:@selector(allClick:) forControlEvents:UIControlEventTouchUpInside];
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
        romNum = 1;
    }
    else if (tableView.tag == 1002)
    {
        romNum = 2;
    }
    else if (tableView.tag == 1003)
    {
        romNum = 3;
    }
    else
    {
        romNum = 4;
    }
    return romNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1001)
    {
        static NSString *str = @"identifile_1";
        TableViewCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil)
        {
            cell = [[TableViewCell_1 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        return cell;
    }
    else if (tableView.tag == 1002)
    {
        static NSString *str = @"identifile_1";
        TableViewCell_2 *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil)
        {
            cell = [[TableViewCell_2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        return cell;
    }
    else if (tableView.tag == 1003)
    {
        static NSString *str = @"identifile_1";
        TableViewCell_3 *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil)
        {
            cell = [[TableViewCell_3 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        return cell;
    }
    else
    {
        static NSString *str = @"identifile_1";
        TableViewCell_4 *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil)
        {
            cell = [[TableViewCell_4 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        return cell;
    }
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    _header.scrollView = _tableview_1;
    _footer.scrollView = _tableview_1;

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
    
    _header.scrollView = _tableview_2;
    _footer.scrollView = _tableview_2;

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
    
    _header.scrollView = _tableview_3;
    _footer.scrollView = _tableview_3;

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
    
    _header.scrollView = _tableview_4;
    _footer.scrollView = _tableview_4;

}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
//        _page = 1;
//        [self.jobArr removeAllObjects];
//        
//        [self loadData:refreshView page:_page];
    }
    else{
//        self.page++;
//        [self loadData:refreshView page:_page];
        
    }
}


#pragma mark -- notification

- (void)yichakan
{
    NSLog(@"已查看");
}

- (void)daitongzhi
{
    NSLog(@"待通知");
}

- (void)buheshi
{
    NSLog(@"不合适");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
