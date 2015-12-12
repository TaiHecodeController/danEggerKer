//
//  TH_JobDetailVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_JobDetailVC.h"
#import "JobDescriptionlView.h"
#import "moreJobTableViewCell.h"
#import "CompanyProfil.h"
#import "ComPanyProfileView.h"
#import "MoreJobTitleCell.h"
#import "AFAppRequest.h"
#import "playFanModel.h"
#import "TH_AFRequestState.h"
#import "JobDetailModel.h"
#import "CommonFunc.h"
#import "TH_LoginVC.h"
#import "TH_FindJobVC.h"
#import "findJobModel.h"
#import "TH_HomeVC.h"
#import "TH_MainTabBarController.h"
#import "findJobDetialScriptionViewS.h"
@interface TH_JobDetailVC ()<UITableViewDataSource,UITableViewDelegate,companyProfileViewDelegate,MJRefreshBaseViewDelegate>
{
    //纪录展开之前的frame
    CGRect lab_recordFrame;
    CGRect btn_recordFrame;
    CGRect header_recordFrame;
    CGRect company_recordFrame;
//    CGRect record_Message;
//    CGRect record_SelfView;
//    CGRect record_ShowAll;
//    CGRect record_tabView;
    int _page;

}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UIButton * button;
@property(assign)CGSize textSize;
@property(strong,nonatomic)UIView * headerView;
@property(strong,nonatomic)AFRequestState * state;
@property (nonatomic, strong) MBProgressHUD *mbPro;
@property (nonatomic, strong)findJobDetialScriptionViewS *jobDescription;
@property (nonatomic, strong)ComPanyProfileView *companyprofileView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong) JobDetailModel *model;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSString *isCollect;
@property (nonatomic, strong) UIButton *rightCollectBtn;

@end

@implementation TH_JobDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"jobdetailvc"];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backRoot) name:@"jb_detail" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"jobdetailvc"];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
//    [super viewWillDisappear:NO];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"jb_detail" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"职位详情";
//    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self setStatus];
    [self createsheader];
    [self createTableView];
    [self createDetailView];
    [self searchBtn];
    
    self.page = 1;
    /*数据请求**/
    _mbPro = [MBProgressHUD mbHubShowControllerView:self];
    [self loadData:_mbPro page:1];
    
    UIButton *btn = [UIButton new];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:btn];
    
    //    [self loadData];
    
}

- (void)btnClick
{
    
//    [self.navigationController popToViewController:self.navigationController.visibleViewController animated:YES];
    
//    NSArray *arr = [NSArray arrayWithObjects:<#(nonnull id), ...#>, nil];
//    [self.navigationController setViewControllers:arr animated:YES];
//    NSArray *arr =  self.navigationController.viewControllers ;
//    [arr removeLastObject];
//    [arr removeObjectAtIndex:1];
//    TH_HomeVC *vc = [[TH_HomeVC alloc]init];
//    NSLog(@"%@",arr);
//    [arr addObject:vc];
//    [self.navigationController setViewControllers:arr animated:YES];
//    [arr insertObject:vc atIndex:1];
//    NSLog(@"%@",self.navigationController.viewControllers);
//    [TH_MainTabBarController messagePush];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"messagePush" object:nil];
    
}

-(void)backRoot
{
    [self.navigationController popViewControllerAnimated:NO];
    TH_FindJobVC * findJob = [[TH_FindJobVC alloc] init];
     findJob.rk_pushType = homePushType;
    [self.navigationController  popToViewController:findJob animated:YES];
}

-(void)loadData:(id)notify page:(int)num
{
    if(_state.running)
    {
        return;
    }
    
//    int _id = 23;
//    int pid = 7;
    
//    self.state = [[TH_AFRequestState jobDetailsRequestWithSucc:^(NSDictionary *DataArr) {
//        JobDetailModel * model = (JobDetailModel *)DataArr;
//        [self setHeaderModel:model];
//        _listArr = [NSMutableArray arrayWithArray:model.lists];
//        [self.tableView reloadData];
//        
//    } withfail:^(int errCode, NSError *err) {
//        
//    } withId:_id pid:pid resp:[JobDetailModel class]] addNotifaction:notify];
    
    self.state = [[TH_AFRequestState jobDetailsRequestWithSucc:^(NSDictionary *DataArr) {
        _model = (JobDetailModel *)DataArr;
        [self setHeaderModel:_model];
        _listArr = [NSMutableArray arrayWithArray:_model.lists];
        [self.tableView reloadData];
        
    } withfail:^(int errCode, NSError *err) {
        
    } withId:_uid pid:_pid page:num resp:[JobDetailModel class]] addNotifaction:notify];
}

-(void)searchBtn
{
    UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-119, WIDETH, 106)];
    bgView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self.view addSubview:bgView];
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH-150)/2.0, HEIGHT - 106, 150, 30)];
    [self.view addSubview:button];
    [button setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [button setTitle:@"申请职位" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -- 申请职位按钮
-(void)searchBtnClick
{
    
//    THLog(@"职位申请被点击");
//    
//    _mailingNumBer = 0;
//    //遍历哪个职位被选中
//    NSMutableString *job_idStr = [[NSMutableString alloc]init];
//    for (findJobModel *model in self.jobArr)
//    {
//        if ([model.cellselected isEqualToString: @"1"])
//        {
//            _mailingNumBer++;
//            [job_idStr appendString:[NSString stringWithFormat:@"%@,",model.job_id]];
//            
//        }
//        
//    }
//    NSLog(@"job_idStr%@",job_idStr);
    
    [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    
    if([AppDelegate instance].userId)
    {
      self.state=  [[TH_AFRequestState SQJobWithSucc:^(NSString *DataArr) {
          
          [MBProgressHUD creatembHub:@"申请成功" ControllerView:self];
            
        } withfail:^(int errCode, NSError *err) {
            
            if (errCode == 1)
            {
                [MBProgressHUD creatembHub:@"请先使用简历" ControllerView:self];
            }
            if (errCode == 2)
            {
                [MBProgressHUD creatembHub:@"您已申请过了,一周内不得重复申请" ControllerView:self];
            }
            
        } withUid:nil job_id:_model.cj_id resp:[NSObject class]] addNotifaction:[MBProgressHUD mbHubShowControllerView:self]];
        
    }
    else
    {
       
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alertView.delegate = self;
        [alertView show];
    }

}
#pragma mark -- alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {        TH_LoginVC * lvcs = [[TH_LoginVC alloc] init];
        lvcs.findJobDetailApplication = @"findJobDetailApplication";
        lvcs.loginBlock = ^()
        {
            [self searchBtnClick];
        };
        [self.navigationController pushViewController:lvcs animated:YES];
        
    }
}

-(void)createsheader
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 645 + 100+60)];
    self.headerView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self.view addSubview:self.headerView];
}
#pragma mark -- title
-(void)createDetailView
{
//    JobDescriptionlView * jobDescription = [JobDescriptionlView setJobDescriptionView];
//       jobDescription.frame = CGRectMake(0, 0, WIDETH, 410);
    
    findJobDetialScriptionViewS * jobDescription = [findJobDetialScriptionViewS setFindJobDetialScriptionView];
    jobDescription.frame = CGRectMake(0, 0, WIDETH, 645);
   [self.headerView addSubview:jobDescription];
    
    _jobDescription = jobDescription;
    [jobDescription.jobCroptionTextView setEditable:NO];
  //公司简介
    ComPanyProfileView * companyprofileView = [[ComPanyProfileView alloc] initWithFrame:CGRectMake(0, 645, WIDETH, 160)];
    companyprofileView.backgroundColor = [UIColor whiteColor];
    
    companyprofileView.delegate = self;
    NSString * str = @"根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发的速度不可比拟是你是你.根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发的速度不可比拟是你是你.根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发用的就与开发保证IFA质量";
//    [companyprofileView config:str];
    _companyprofileView = companyprofileView;
    [self.headerView addSubview:companyprofileView];

}
-(void)CompanyProfilView:(ComPanyProfileView *)companyView
{
    if (!companyView.selectBtn.isSelected) {
        
        NSString * description = companyView.detailLable.text;
         CGSize textSize = [description sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH-30, 2000)];
        self.textSize = textSize;
        [UIView animateWithDuration:0.1 animations:^{
            
            company_recordFrame = companyView.frame;
            //company的frame
        companyView.frame = CGRectMake(0, 645, companyView.frame.size.width, companyView.frame.size.height + textSize.height - 50);
            
            //改变label的frame
            lab_recordFrame = companyView.detailLable.frame;
            companyView.detailLable.frame = CGRectMake(companyView.detailLable.frame.origin.x, companyView.detailLable.frame.origin.y, textSize.width, textSize.height);
            companyView.detailLable.numberOfLines = 0;
            
            
                        //按钮的frame
                btn_recordFrame = companyView.selectBtn.frame;
                companyView.selectBtn.frame = CGRectMake(companyView.selectBtn.frame.origin.x, companyView.detailLable.frame.origin.y + companyView.detailLable.frame.size.height+20 , companyView.selectBtn.frame.size.width, companyView.selectBtn.frame.size.height);
                header_recordFrame = self.headerView.frame;
                self.headerView.frame = CGRectMake(0, self.headerView.origin.y, WIDETH, self.headerView.origin.y + self.headerView.frame.size.height + textSize.height - 50);
            self.tableView.tableHeaderView = self.headerView;
            }];
        
    }else
    {
        
        [UIView animateWithDuration:.1 animations:^{
                        //收起的时候还原控件位置
                        companyView.detailLable.frame = lab_recordFrame;
                        companyView.detailLable.numberOfLines = 4;
            
                        companyView.selectBtn.frame = btn_recordFrame;
                        companyView.frame = company_recordFrame;
                        self.headerView.frame = header_recordFrame;
                        self.tableView.tableHeaderView = self.headerView;
                    }];

    }
    companyView.selectBtn.selected = !companyView.selectBtn.selected;

}
-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT - 119) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    _header.scrollView = self.tableView;
    
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    _footer.scrollView = self.tableView;
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView == _header)
    {
        _page = 1;
        [self loadData:_mbPro page:_page];
    }else
    {
        _page ++;
        [self loadData:refreshView page:_page];
    }
}

-(void)dealloc
{
    [_header free];
    [_footer free];
}

#pragma mark tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //头部
    if(indexPath.row == 0)
    {
        MoreJobTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"moreJob"];
        if(!cell)
        {
            cell = [[MoreJobTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreJob"];
        }
        return cell;
    }
    
    //身体
    NSString * identifier = @"identifier";
    moreJobTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"moreJobTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    list_item *liModel = self.listArr[indexPath.row];
    cell.positionName.text = liModel.name;
//    cell.time.text = liModel.lastupdate;
    NSString * dateStr = liModel.lastupdate;
    cell.time.text = [dateStr substringFromIndex:5];
    

    cell.companyName.text = liModel.com_name;
    cell.addres.text = liModel.provinceid;
    cell.knowdelge.text = liModel.edu;
    cell.salary.text = liModel.salary;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.row == 0)
    {
        return 53;
    }
    return 78;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    list_item *liModel = self.listArr[indexPath.row];
    _pid = [liModel.id intValue];
   
    /*数据请求**/
//    _mbPro = [MBProgressHUD mbHubShow];
//    [self loadData:_mbPro page:0];
//        TH_JobDetailVC * detail = [[TH_JobDetailVC alloc] init];
//    findJobModel *fjmodel = self.listArr[indexPath.row];
//    detail.uid = [fjmodel.uid intValue];
//    detail.pid = [fjmodel.job_id intValue];
//    detail.saveBOOL = 1;
//
//   [self.navigationController pushViewController:detail animated:YES];
    TH_JobDetailVC * detail = [[TH_JobDetailVC alloc] init];
//    record_index = indexPath;
    detail.uid = _uid;
    detail.pid =  _pid;
    detail.saveBOOL = 1;
    //        NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    //        NSLog(@"uid%@",[df objectForKey:@"uid"]);
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)setStatus
{
    UIButton * rightCollectBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH - 10, 12, 20, 20)];
    [rightCollectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [rightCollectBtn setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateSelected];
    [rightCollectBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _rightCollectBtn = rightCollectBtn;
    
    if (_saveBOOL == 0)
    {
        //从收藏职位列表跳到详情，详情页不加收藏按钮
    }
    else
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightCollectBtn];
    }
    
}

#pragma set方法
- (void)setHeaderModel:(JobDetailModel *)model
{
    //    @property (weak, nonatomic) IBOutlet UIImageView *logoView;
    //    @property (weak, nonatomic) IBOutlet UILabel *jobNameLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *companyNameLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *releaseTimeLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *closeTImeLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *salaryLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *workYearLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *studyLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *addressLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *natureLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *recruitLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *genderLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *marraigeLable;
    //    @property (weak, nonatomic) IBOutlet UILabel *dutyLable;
    //    @property (weak, nonatomic) IBOutlet UITextView *jobCroptionTextView;
    //    @property (weak, nonatomic) IBOutlet UILabel *compayAddressLable;
    [_jobDescription.logoView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"morenqiyekapian"]];
    _jobDescription.jobNameLable.text = model.cj_name;
    _jobDescription.companyNameLable.text = model.com_name;
    _jobDescription.releaseTimeLable.text = model.sdate;
    _jobDescription.closeTImeLable.text = model.edate;
    _jobDescription.salaryLable.text = model.salary;
    _jobDescription.workYearLable.text = model.exp;
    _jobDescription.studyLable.text = model.edu;
    _jobDescription.addressLable.text = model.address;
    _jobDescription.natureLable.text = model.type;
    _jobDescription.recruitLable.text = model.number;
    _jobDescription.genderLable.text = model.sex;
    _jobDescription.marraigeLable.text = model.marriage;
    _jobDescription.dutyLable.text = model.edu;
    _jobDescription.compayAddressLable.text = model.address;
    
    if ([model.iscollect isEqual:@"0"])
    {
        _rightCollectBtn.selected = NO;
        [_rightCollectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }
    else if([model.iscollect isEqual:@"1"])
    {
        _rightCollectBtn.selected = YES;
        [_rightCollectBtn setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateSelected];
    }
    
    NSString *htmlString = [CommonFunc textFromBase64String:model.cj_description];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _jobDescription.jobCroptionTextView.attributedText = attributedString;
    
    
    
    if ([model.type isEqualToString:@"54"])
    {
        _jobDescription.natureLable.text = @"不限";
    }
    else if ([model.type isEqualToString:@"55"])
    {
        _jobDescription.natureLable.text = @"全职";
    }
    else if ([model.type isEqualToString:@"56"])
    {
        _jobDescription.natureLable.text = @"兼职";
    }
    else
    {
        _jobDescription.natureLable.text = @"实习";
    }

    

    NSString *comHtmlString = [CommonFunc textFromBase64String:model.content];
  
    NSString *str =  [self flattenHTML:comHtmlString trimWhiteSpace:YES];
    
    self.textSize = [ [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
     _companyprofileView.detailLable.text =  [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];

    
}
-(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

#pragma mark- - 收藏
-(void)rightBtnClick:(UIButton *)sender
{
  
    
    [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    
    if([AppDelegate instance].userId)
    {
        sender.selected = !sender.selected;
        
        if (sender.selected== YES)
        {
            self.state = [[TH_AFRequestState saveJobWithSucc:^(NSDictionary *DataArr) {
                
                NSLog(@"%@",DataArr);
                
            [MBProgressHUD creatembHub:@"收藏成功" ControllerView:self];
                
            } withFail:^(int errCode, NSError *err) {
                
                NSLog(@"%@",err);
                
            } withJob_id:[_model.cj_id intValue] resp:[NSObject class]] addNotifaction:[MBProgressHUD mbHubShowControllerView:self]];
        }
        else if(sender.selected == NO)
        {
            self.state = [[TH_AFRequestState saveJobWithSucc:^(NSDictionary *DataArr) {
                
                NSLog(@"%@",DataArr);
                [MBProgressHUD creatembHub:@"取消收藏" ControllerView:self];
                
            } withFail:^(int errCode, NSError *err)
                           {
                               
                               NSLog(@"%@",err);
                               
                           } withJob_id:[_model.cj_id intValue] resp:[NSObject class]] addNotifaction:[MBProgressHUD mbHubShowControllerView:self]];
        }

                
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alertView.delegate = self;
        [alertView show];
    }

}

/*
 company_recordFrame = companyView.frame;
 //company的frame
 //            companyView.frame = CGRectMake(0, 410, companyView.frame.size.width, companyView.frame.size.height + textSize.height - 100);
 companyView.frame = CGRectMake(0, companyView.frame.origin.y, companyView.frame.size.width, companyView.frame.size.height + textSize.height - companyView.detailLable.frame.size.height);
 
 //改变label的frame
 lab_recordFrame = companyView.detailLable.frame;
 companyView.detailLable.frame = CGRectMake(companyView.detailLable.frame.origin.x, companyView.detailLable.frame.origin.y-15, textSize.width, textSize.height);
 companyView.detailLable.numberOfLines = 0;
 //按钮的frame
 btn_recordFrame = companyView.selectBtn.frame;
 //            companyView.selectBtn.frame = CGRectMake(companyView.selectBtn.frame.origin.x, companyView.detailLable.frame.origin.y + companyView.detailLable.frame.size.height -10, companyView.selectBtn.frame.size.width, companyView.selectBtn.frame.size.height);
 companyView.selectBtn.frame = CGRectMake(companyView.selectBtn.frame.origin.x, CGRectGetMaxY(companyView.detailLable.frame) + 10, companyView.selectBtn.frame.size.width, companyView.selectBtn.frame.size.height);
 
 header_recordFrame = self.headerView.frame;
 //            self.headerView.frame = CGRectMake(0, self.headerView.origin.y, WIDETH, self.headerView.origin.y + self.headerView.frame.size.height + textSize.height - 100);
 //
 self.headerView.frame = CGRectMake(0, self.headerView.origin.y, WIDETH, self.headerView.origin.y + self.headerView.frame.size.height + textSize.height - lab_recordFrame.size.height);
 self.tableView.tableHeaderView = self.headerView;
 **/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
