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
@end

@implementation TH_JobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"职位详情";
//    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self setStatus];
    [self createsheader];
    [self createTableView];
    [self createDetailView];
    [self searchBtn];
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

-(void)searchBtnClick
{
    NSLog(@"申请职位");
}

-(void)createsheader
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 510)];
    self.headerView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self.view addSubview:self.headerView];
}
-(void)createDetailView
{
    JobDescriptionlView * jobDescription = [JobDescriptionlView setJobDescriptionView];
       jobDescription.frame = CGRectMake(0, 0, WIDETH, 350);
   [self.headerView addSubview:jobDescription];
//        CompanyProfil * company =  [[[NSBundle mainBundle] loadNibNamed:@"CompanyProfile" owner:self options:nil]lastObject];
//    [company companyProfilSelcet];
//    company.frame = CGRectMake(0, 350, WIDETH, 160);
    ComPanyProfileView * companyprofileView = [[ComPanyProfileView alloc] initWithFrame:CGRectMake(0, 350, WIDETH, 160)];
    companyprofileView.backgroundColor = [UIColor whiteColor];
    
    companyprofileView.delegate = self;
    NSString * str = @"根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发的速度不可比拟是你是你.根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发的速度不可比拟是你是你.根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发用的就与开发保证IFA质量";
    [companyprofileView config:str];
    [self.headerView addSubview:companyprofileView];

}
-(void)CompanyProfilView:(ComPanyProfileView *)companyView
{
    if (!companyView.selectBtn.isSelected) {
        NSString * description = companyView.detailLable.text;
         CGSize textSize = [description sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(WIDETH-30, 2000)];
        self.textSize = textSize;
        [UIView animateWithDuration:0.1 animations:^{
            company_recordFrame = companyView.frame;
            
            //company的frame
        companyView.frame = CGRectMake(0, 350, companyView.frame.size.width, companyView.frame.size.height + textSize.height - 60);
            
            //改变label的frame
            lab_recordFrame = companyView.detailLable.frame;
            companyView.detailLable.frame = CGRectMake(companyView.detailLable.frame.origin.x, companyView.detailLable.frame.origin.y, textSize.width, textSize.height);
            companyView.detailLable.numberOfLines = 0;
            
            
                        //按钮的frame
                btn_recordFrame = companyView.selectBtn.frame;
                companyView.selectBtn.frame = CGRectMake(companyView.selectBtn.frame.origin.x, companyView.detailLable.frame.origin.y + companyView.detailLable.frame.size.height + 10, companyView.selectBtn.frame.size.width, companyView.selectBtn.frame.size.height);
                header_recordFrame = self.headerView.frame;
                self.headerView.frame = CGRectMake(0, self.headerView.origin.y, WIDETH, self.headerView.origin.y + self.headerView.frame.size.height + textSize.height - 60);
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
self.scro.contentSize = CGSizeMake(WIDETH, 510+self.tableView.frame.size.height-10+self.textSize.height);
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
        [self loadData:_header Page:_page];
    }else
    {
        _page ++;
        [self loadData:_footer Page:_page];
    }
}

-(void)loadData:(id)notify Page:(int)page
{
    if(_state.running)
    {
        return;
    }else
    {
        [[TH_AFRequestState playClassrRequestWithSucc:^(NSArray *DataDic) {
            
        } resp:[playFanModel class] withPage:[NSString stringWithFormat:@"%d",page]] addNotifaction:notify];
    }
    
}

-(void)dealloc
{
    [_header free];
    [_footer free];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        MoreJobTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"moreJob"];
        if(!cell)
        {
            cell = [[MoreJobTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreJob"];
        }
        return cell;
    }
    NSString * identifier = @"identifier";
    moreJobTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"moreJobTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
   
    [self.navigationController pushViewController:[[TH_JobDetailVC alloc] init] animated:YES];
}

-(void)setStatus
{
    UIButton * rightCollectBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH - 10, 12, 20, 20)];
    [rightCollectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [rightCollectBtn setImage:[UIImage imageNamed:@"shoucang2"] forState:UIControlStateSelected];
    [rightCollectBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightCollectBtn];

}
#pragma mark- - 收藏
-(void)rightBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
//    UIAlertView * alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
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