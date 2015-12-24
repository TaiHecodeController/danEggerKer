//
//  TH_TalentPoolVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//
/*
 人才库
 *
 */
#import "TH_TalentPoolVC.h"
#import "TalentPoolCell.h"
#import "enterPriseRequest.h"
#import "TalentModel.h"

#define bottomHeight 48
//每页显示的条数
#define pageNum 10

@interface TH_TalentPoolVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    THMBProgressHubView * _mbPro;
}

@property (nonatomic, strong) UITableView *tableview_1;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *deletBtn;
@property (nonatomic, strong) UIButton *kuangIcon;
@property (nonatomic, strong) UILabel *allSelLab;

@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property (nonatomic) int page;
@property (nonatomic,strong)AFRequestState * state;

@property (nonatomic, strong) NSMutableArray *resumeList;

@end

@implementation TH_TalentPoolVC

-(void)dealloc
{
    [_header free];
    [_footer free];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resumeList = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = color(240, 240, 237);
    
    self.title = @"人才库";
    
    _tableview_1 = [[UITableView alloc] init];
    _tableview_1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview_1.frame = CGRectMake(0,10, WIDETH, HEIGHT - bottomHeight - 20 -44 );
    [self.view addSubview:_tableview_1];
    _tableview_1.backgroundColor = [UIColor clearColor];
    _tableview_1.dataSource = self;
    _tableview_1.delegate = self;
    
    [self addBottomView];
    
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    //上拉刷新
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    
    _header.scrollView = _tableview_1;
    _footer.scrollView = _tableview_1;

    _page = 1;
    _mbPro = [MBProgressHUD mbHubShowMBProgressHubView:self];
    [self querDataWithcomid:1869 pageIndex:_page page:pageNum noti:_mbPro];
}

- (void)querDataWithcomid:(int)com_id pageIndex:(int)pageIndex page:(int)page noti:(id)noti
{
    [[enterPriseRequest requestTanlentLibWithSucc:^(NSArray *DataDic) {
        
        if (DataDic.count >0)
        {
            [self.resumeList addObjectsFromArray:DataDic];
            [_tableview_1 reloadData];
        }
        
    } com_id:com_id pageIndex:pageIndex page:page resp:[TalentModel class]] addNotifaction:noti];
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
    _deletBtn.frame = CGRectMake((WIDETH - 195 * MyWideth) / 2, 9, 195 * MyWideth, 30 * MyWideth);
    [_deletBtn addTarget:self action:@selector(deletBtnClick) forControlEvents:UIControlEventTouchUpInside];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resumeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 120;
    TalentPoolCell *cell = (TalentPoolCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"identifile";
    TalentPoolCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil)
    {
        cell = [[TalentPoolCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    if(self.resumeList.count >0)
    {
        TalentModel *model = self.resumeList[indexPath.row];
        [cell config:model];
        cell.icon_seleted = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
        [cell.selIcon addTarget:self action:@selector(single_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell layoutSubviews];
    }
    
    return cell;
    
}

#pragma mark -- respondEvent
- (void)allClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        //选中所有
        for (int i = 0; i<self.resumeList.count; i++) {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            TalentModel *model = self.resumeList[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"1";
        }
        
        [_tableview_1 reloadData];
        
    }
    else
    {
        sender.selected = NO;
        //失选所有
        for (int i = 0; i<self.resumeList.count; i++)
        {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            TalentModel *model = self.resumeList[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"0";
        }
        [_tableview_1 reloadData];
    }
}

- (void)single_Click:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        
        TalentPoolCell *cell = (TalentPoolCell *)[sender superview];
        NSIndexPath *indexPath = [_tableview_1 indexPathForCell:cell];
        TalentModel *fjModel = self.resumeList[indexPath.row];
        fjModel.cellselected = @"1";
        
    }
    else
    {
        sender.selected = NO;
        TalentPoolCell *cell = (TalentPoolCell *)[sender superview];
        NSIndexPath *indexPath = [_tableview_1 indexPathForCell:cell];
        TalentModel *fjModel = self.resumeList[indexPath.row];
        fjModel.cellselected = @"0";
    }
    
}

- (void)deletBtnClick
{
    
    //去所有eid
    NSMutableString *eidstr = [[NSMutableString alloc]init];
    for (TalentModel *model in self.resumeList)
    {
        if ([model.cellselected isEqualToString: @"1"])
        {
            [eidstr appendString:[NSString stringWithFormat:@"%@,",model.eid]];
            
        }
        
    }
    NSLog(@"eidstr%@",eidstr);
   
    [[enterPriseRequest requestDeletTanlentWithSucc:^(NSDictionary *DataDic) {
        
        _page = 1;
        [self.resumeList removeAllObjects];
        [self querDataWithcomid:1869 pageIndex:_page page:pageNum noti:_mbPro];
        
    } com_id:1869 eid:eidstr] addNotifaction:_mbPro];
    
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header )
    {
        _page = 1;
        [self.resumeList removeAllObjects];
        [self querDataWithcomid:1869 pageIndex:_page page:pageNum noti:refreshView];
        
    }
    else
    {
        
        _page++;
        [self querDataWithcomid:1869 pageIndex:_page page:pageNum noti:refreshView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
