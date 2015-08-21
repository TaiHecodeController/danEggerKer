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
@interface TH_JobDetailVC ()<UITableViewDataSource,UITableViewDelegate,companyProfileViewDelegate>
{
    //纪录展开之前的frame
    CGRect lab_recordFrame;
    CGRect btn_recordFrame;
    CGRect tableView_recordFrame;
    CGRect company_recordFrame;
//    CGRect record_Message;
//    CGRect record_SelfView;
//    CGRect record_ShowAll;
//    CGRect record_tabView;

}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UIButton * button;
@property(assign)CGSize textSize;
@end

@implementation TH_JobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"职位详情";
//    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self setStatus];
    [self createscro];
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

-(void)createscro
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-25-49)];
    self.scro = scro;
//    self.scro.backgroundColor =[UIColor redColor];
    self.scro.showsVerticalScrollIndicator = YES;
    [self.view addSubview:scro];
}
-(void)createDetailView
{
    JobDescriptionlView * jobDescription = [JobDescriptionlView setJobDescriptionView];
       jobDescription.frame = CGRectMake(0, 0, WIDETH, 350);
   [self.scro addSubview:jobDescription];
//        CompanyProfil * company =  [[[NSBundle mainBundle] loadNibNamed:@"CompanyProfile" owner:self options:nil]lastObject];
//    [company companyProfilSelcet];
//    company.frame = CGRectMake(0, 350, WIDETH, 160);
    ComPanyProfileView * companyprofileView = [[ComPanyProfileView alloc] initWithFrame:CGRectMake(0, 350, WIDETH, 160)];
    companyprofileView.backgroundColor = [UIColor whiteColor];
    
    companyprofileView.delegate = self;
    NSString * str = @"根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发的速度不可比拟是你是你.根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发的速度不可比拟是你是你.根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发用的就与开发保证IFA质量";
    [companyprofileView config:str];
    [self.scro addSubview:companyprofileView];

}
-(void)CompanyProfilView:(ComPanyProfileView *)companyView
{
    
    NSLog(@"hdhcdkj");
    
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
                        tableView_recordFrame = self.tableView.frame;
                        //tableView的frame
                        self.tableView.frame = CGRectMake(0, companyView.frame.size.height + companyView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
                    }];
        
    }else
    {
        
        [UIView animateWithDuration:.1 animations:^{
                        //收起的时候还原控件位置
                        companyView.detailLable.frame = lab_recordFrame;
                        companyView.detailLable.numberOfLines = 4;
            
                        companyView.selectBtn.frame = btn_recordFrame;
                        companyView.frame = company_recordFrame;
                        self.tableView.frame = tableView_recordFrame;
                    }];

    }
    companyView.selectBtn.selected = !companyView.selectBtn.selected;
self.scro.contentSize = CGSizeMake(WIDETH, 510+self.tableView.frame.size.height-10+self.textSize.height);
}
-(void)createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 510, WIDETH, HEIGHT-50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView = tableView;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.scro addSubview:tableView];
    self.scro.contentSize = CGSizeMake(WIDETH, 510+self.tableView.frame.size.height-10+56 );
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

    return 78;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView  * heatView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 53)];
   
    UIView * lineVew = [[UIView alloc] initWithFrame:CGRectMake(15, 25, 2, 15)];
    lineVew.backgroundColor = color(244, 67, 54);
    [heatView addSubview:lineVew];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 10)];
    bgView.backgroundColor = color(243, 243, 241);
    [heatView addSubview:bgView];
    UILabel * RelatedLable = [[UILabel alloc] initWithFrame:CGRectMake(21, 25, 100, 13)];
    RelatedLable.text = @"该公司更多职位";
    RelatedLable.textColor = color(100, 100, 100);
    RelatedLable.font =[UIFont systemFontOfSize:13];
    [heatView addSubview:RelatedLable];
    UIView * linebgViw = [[UIView alloc] initWithFrame:CGRectMake(15, 50, WIDETH-15, 0.5)];
    linebgViw.backgroundColor = color(200, 200, 200);
    [heatView addSubview:linebgViw];
    heatView.backgroundColor = [UIColor whiteColor];
    return heatView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53;
}
-(void)setStatus
{
    UIButton * rightCollectBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH - 10, 12, 20, 20)];
    [rightCollectBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [rightCollectBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightCollectBtn];

}
#pragma mark- - 收藏
-(void)rightBtnClick
{
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
