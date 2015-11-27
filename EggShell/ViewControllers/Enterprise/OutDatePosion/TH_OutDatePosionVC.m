//
//  TH_OutDatePosionVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//
/*
 过期职位类
 *
 */
#import "TH_OutDatePosionVC.h"
#import "AllPosionCell.h"
#import "AllPosionModel.h"
#import "enterPriseRequest.h"
@interface TH_OutDatePosionVC ()<UITableViewDataSource,UITableViewDelegate
,MJRefreshBaseViewDelegate>
{
    MBProgressHUD * _mbPro;
    //时间选择
    NSString * dateStr;
    UIButton * record_btn;
    UIView * backView;
    UIButton * ok;
}
@property(nonatomic,strong)UITableView  * tableView;
@property (nonatomic,strong)AFRequestState * state;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int limitNum;
@property(nonatomic,copy)NSString * extensionDateStr;
//时间选择
@property (strong,nonatomic)UIDatePicker * dataPicker;
@end

@implementation TH_OutDatePosionVC
-(void)dealloc
{
    
    [_header free];
    [_footer free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"过期职位";
    self.limitNum = 3;
    self.page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
self.view.backgroundColor = color(240, 240, 237);
    [self createTableView];
    //底部选框
    [self  createSelectBtn];
    [self loadData:self.limitNum page:self.page notif:[MBProgressHUD mbHubShow]];
}
-(void)loadData:(int)limitNum page:(int)page notif:(id)notify
{
    if(_state.running)
    {
        return;
    }
    NSString * uid = [NSString stringWithFormat:@"%d",1869];
    NSString * jobstatus =[NSString stringWithFormat:@"%d",2];
    NSNumber  * pagenum =[NSNumber numberWithInt:page];
    NSNumber *   pagesize = [NSNumber numberWithInt:limitNum];
    NSDictionary * param = @{@"uid":uid,@"jobstatus":jobstatus,@"pagenum":pagenum,@"pagesize":pagesize};
    self.state = [[TH_AFRequestState EnterpriseFullPositionWithSucc:^(NSArray *dic) {
        [self.dataArray addObjectsFromArray:dic];
        [self.tableView reloadData];
    } withd:param resp:[AllPosionModel class]] addNotifaction:notify];
    
}

-(void)createSelectBtn
{
    UIView * bottoBgVieW =[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 64-50, WIDETH, 50)];
    bottoBgVieW.backgroundColor = [UIColor whiteColor];
    bottoBgVieW.layer.borderWidth = 0.8;
    bottoBgVieW.layer.borderColor = UIColorFromRGB(0xDDDDDD).CGColor;
    [self.view addSubview:bottoBgVieW];
    //按钮选框
    UIButton *   marqueeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*MyWideth, 5*MyWideth, 40*MyWideth, 40*MyWideth)];
    [marqueeBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [marqueeBtn setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
    [marqueeBtn addTarget:self action:@selector(marqueeBtnClck:) forControlEvents:UIControlEventTouchUpInside];
    [bottoBgVieW addSubview:marqueeBtn];
    //文字
    UILabel * allLalbe = [[UILabel alloc] initWithFrame:CGRectMake(55*MyWideth, 15*MyWideth,35*MyWideth , (60*MyWideth-30*MyWideth)/2)];
    allLalbe.text = @"全选";
    allLalbe.font = [UIFont systemFontOfSize:15*MyWideth];
    allLalbe.textColor = UIColorFromRGB(0xF44336);
    [bottoBgVieW addSubview:allLalbe];
    NSArray * titileArray = @[@"职位延期",@"删除"];
    for (int i = 0 ; i < titileArray.count; i++) {
        UIButton * electBtn = [[UIButton alloc] initWithFrame:CGRectMake(55*MyWideth+15*MyWideth+35*MyWideth+((WIDETH -(55*MyWideth+15*MyWideth+48*MyWideth+35*MyWideth))/3)*i+15*MyWideth*i, 10*MyWideth, (WIDETH -(55*MyWideth+15*MyWideth+48*MyWideth+35*MyWideth))/3 , 30*MyWideth)];
        electBtn.backgroundColor =[UIColor redColor];
        electBtn.titleLabel.font = [UIFont systemFontOfSize:15*MyWideth];
        [electBtn setTitle:titileArray[i] forState:UIControlStateNormal];
        [bottoBgVieW addSubview:electBtn];
        //切圆角
        electBtn.layer.cornerRadius = 3;
        electBtn.layer.masksToBounds = YES;
        if (i == 0) {
            electBtn.backgroundColor = UIColorFromRGB(0xF44336);
        }else
        {
        electBtn.backgroundColor = UIColorFromRGB(0x37ACF4);
        }
       
        electBtn.tag = i;
        [electBtn addTarget:self action:@selector(electBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark 职位延期删除
-(void)electBtn:(UIButton*)sender
{
    if (sender.tag == 0) {
        record_btn = sender;
        [self createDataPickView];
    }if (sender.tag == 1) {
        NSMutableString *job_idStr = [[NSMutableString alloc]init];
        for (AllPosionModel *model in self.dataArray)
        {
            if ([model.cellselected isEqualToString: @"1"])
            {
                //            _mailingNumBer++;
                [job_idStr appendString:[NSString stringWithFormat:@"%@,",model.cj_id]];
                
            }
            
        }
        if (job_idStr == nil) {
           
             [MBProgressHUD creatembHub:@"请选择要删除的职位"];
            
        }else
        {

        NSLog(@"cj_id:%@",job_idStr);
        NSLog(@"cj_id:%@",job_idStr);
        NSString * uid = [NSString stringWithFormat:@"%d",1869];
        NSString * changeStatus = [NSString stringWithFormat:@"%d",2];
        
        NSDictionary * param = @{@"uid":uid,@"jobid":job_idStr,@"changestatus":changeStatus};
        [enterPriseRequest FulltimeJobsPauseResumeWithSucc:^(NSDictionary *DataDic) {
             [MBProgressHUD creatembHub:@"职位删除成功"];
            
        } withParam:param];
        }
    }
}
#pragma mark   延期时间选择
-(void)createDataPickView
{
    
    backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    [[AppDelegate instance].window addSubview:backView];
    //创建picker
    self.dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDETH, HEIGHT / 2 - 80)];
    self.dataPicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [[AppDelegate instance].window addSubview:self.dataPicker];
    [self.dataPicker addTarget:self action:@selector(dataChanged:) forControlEvents:UIControlEventValueChanged];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置显示为中文
    self.dataPicker.locale = locale;
    self.dataPicker.datePickerMode = UIDatePickerModeDate;
    //当前时间创建NSDate
    NSDate * localDate = [NSDate date];
    //设置时间
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    NSDate * minDate = [dateFormatt dateFromString:@"1910-1-1"];
    
    //设置属性
    self.dataPicker.maximumDate = localDate;
    self.dataPicker.minimumDate = minDate;
    
    ok = [ZCControl createButtonWithFrame:CGRectMake(WIDETH - 40, HEIGHT, 40, 30) ImageName:@"" Target:self Action:@selector(okClick) Title:@"确定"];
    self.dataPicker.userInteractionEnabled = YES;
    [ok setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[AppDelegate instance].window addSubview:ok];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.dataPicker.frame = CGRectMake(0, HEIGHT / 2 + 90*MyHeight, WIDETH, HEIGHT / 2 - 80);
        ok.frame = CGRectMake(WIDETH - 50, HEIGHT - 100*MyHeight, 40, 30);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)okClick
{
    [backView removeFromSuperview];
    
    [self.dataPicker removeFromSuperview];
    
    [ok removeFromSuperview];
    if(dateStr == nil)
    {
        NSDate * localDate = [NSDate date];
        //设置时间
        NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
        [dateFormatt setDateFormat:@"yyyy-MM-dd"];
        dateStr = [dateFormatt stringFromDate:localDate];
    }
    //    [record_btn setTitle:dateStr forState:UIControlStateSelected];
    //    record_btn.selected = YES;
    self.extensionDateStr = dateStr;
    
    dateStr = nil;
    //数据请求
    [self request];
}
-(void)request
{
    NSMutableString *job_idStr = [[NSMutableString alloc]init];
    for (AllPosionModel *model in self.dataArray)
    {
        if ([model.cellselected isEqualToString: @"1"])
        {
            [job_idStr appendString:[NSString stringWithFormat:@"%@,",model.cj_id]];
            
        }
    }
    if (job_idStr == nil) {
        [MBProgressHUD creatembHub:@"请选择要延期的职位"];
        
    }else
    {

    NSLog(@"cj_id:%@",job_idStr);
    NSString * uid = [NSString stringWithFormat:@"%d",1869];
    NSString * changeStatus = [NSString stringWithFormat:@"%d",3];
    NSDictionary * param = @{@"uid":uid,@"jobid":job_idStr,@"changestatus":changeStatus,@"totime":self.extensionDateStr};
    [enterPriseRequest FulltimeJobsPauseResumeWithSucc:^(NSDictionary *DataDic) {
         [MBProgressHUD creatembHub:@"职位延期成功"];
        
    } withParam:param];
    }
}

-(void)dataChanged:(UIDatePicker *)sender
{
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    dateStr = [dateFormatt stringFromDate:sender.date];
    
}


#pragma mark --- 全选点击事件
-(void)marqueeBtnClck:(UIButton*)sender
{
//    sender.selected = !sender.selected;
    [self allClick:sender];
}
#pragma mark -- respondEvent
- (void)allClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        //选中所有
        for (int i = 0; i<self.dataArray.count; i++) {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            AllPosionModel *model = self.dataArray[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"1";
        }
        
        [_tableView reloadData];
        
    }
    else
    {
        sender.selected = NO;
        //失选所有
        for (int i = 0; i<self.dataArray.count; i++)
        {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            AllPosionModel *model = self.dataArray[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"0";
        }
        [_tableView reloadData];
    }
}


-(void)createTableView
{
    UITableView *  tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT - 64-50)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = color(240, 240, 237);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.tableView;
    _footer.delegate = self;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AllPosionCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[AllPosionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    if (self.dataArray.count !=0) {
        AllPosionModel * model = self.dataArray[indexPath.row];
        [cell configValue:model];
        cell.jobSelected = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
        [cell.marqueeBtn addTarget:self action:@selector(single_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell layoutSubviews];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105* MyWideth;
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 1;
        [self.dataArray removeAllObjects];
        [self loadData:self.limitNum page:_page notif:refreshView];
    }
    else{
        self.page++;
        
        THLog(@"上拉加载更多");
        [self loadData:self.limitNum page:self.page notif:refreshView];
    }
}

- (void)single_Click:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        
        AllPosionCell *cell = (AllPosionCell *)[sender superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        AllPosionModel *fjModel = self.dataArray[indexPath.row];
        fjModel.cellselected = @"1";
        //        [_cellIndeSet addIndex:indexPath.row];
        
    }
    else
    {
        sender.selected = NO;
        
        AllPosionCell *cell = (AllPosionCell *)[sender superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        AllPosionModel *fjModel = self.dataArray[indexPath.row];
        fjModel.cellselected = @"0";
        //        [_cellIndeSet removeIndex:indexPath.row];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
