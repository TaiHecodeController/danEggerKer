//
//  TH_JobScreeningVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/17.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_JobScreeningVC.h"
#import "JobScreeningCell.h"
#import "TH_JobScreenDetailVC.h"
@interface TH_JobScreeningVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,strong)NSArray * conrentArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIScrollView * scro;
/*类别的选择**/
@property(nonatomic,strong)NSArray * industryArray;
@end

@implementation TH_JobScreeningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSco];
    [self setData];
    [self creatableView];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self InquireBtn];
    // Do any additional setup after loading the view.
}
-(void)setData
{
    self.nameArray = @[@"行业类别",@"职位类别",@"工作城市",@"薪资待遇",@"学历要求",@"工作经验",@"工作类型",@"发布时间"];
    self.conrentArray = @[@"计算机/互联网",@"技术人员/助理",@"北京",@"3000-10000",@"本科",@"3年",@"全职",@"一天内"];
    
    self.industryArray = @[@"不限",@"计算机/互联网",@"机械/设备/技工",@"贸易/百货",@"化工/能源",@"公务员/翻译/其他",@"服务业",@"咨询/法律/教育/科研",@"人事/行政/高级管理",@"建筑/房地产",@"广告/市场/媒体/艺术",@"生物/制药/医疗/护理",@"生产/营运/采购/物流",@"会计/金融/银行/保险",@"销售/客服/技术支持",@"信息/电子"];
}
-(void)createSco
{

    UIScrollView * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.backgroundColor =  UIColorFromRGB(0xF3F3F1);

    [self.view addSubview:scro];
    self.scro = scro;
    self.scro.showsVerticalScrollIndicator = NO;
}
-(void)InquireBtn
{
    UIButton * inquireBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH-150)/2, self.tableView.frame.size.height+20, 150, 30)];
   
    [inquireBtn setBackgroundImage:[UIImage imageNamed:@"hongniu2"] forState:UIControlStateNormal];
    [inquireBtn setTitle:@"查询" forState:UIControlStateNormal];
    [inquireBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    inquireBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [inquireBtn addTarget:self action:@selector(inqireClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:inquireBtn];
    self.scro.contentSize = CGSizeMake(WIDETH, self.tableView.frame.size.height+20+80+50);
}
/*查询**/
-(void)inqireClick
{

}
-(void)creatableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 378)];
    self.tableView  = tableView;
    tableView.dataSource= self;
    tableView.delegate = self;
    tableView.layer.borderColor = color(221, 221, 221).CGColor;
    tableView.layer.borderWidth = 0.5;
    tableView.separatorColor = color(221, 221, 221);
    tableView.scrollEnabled= NO;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 0.5)];
    tableView.tableFooterView.backgroundColor = color(221, 221, 221);
    tableView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self.scro addSubview:tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    JobScreeningCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JobScreeningCell" owner:self options:nil]lastObject];
    }
    cell.titleLable.text = self.nameArray[indexPath.row];
    cell.contenLable.text  = self.conrentArray[indexPath.row];
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 42)];
    
    UILabel * CategorieLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15,60, 13)];
    CategorieLable.text = @"关键字";
    CategorieLable.font =[UIFont systemFontOfSize:13];
    [bgView addSubview:CategorieLable];
    
    UILabel * contenLable =[[UILabel alloc] initWithFrame:CGRectMake(100, 15, WIDETH-165, 13)];
    contenLable.text = @"数据分析员";
    contenLable.font =[UIFont systemFontOfSize:13];
    contenLable.textAlignment = UITextAlignmentRight;
    UIView * lineView =[[UIView alloc] initWithFrame:CGRectMake(15, 41.5, WIDETH-15, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [bgView addSubview:lineView];
    [bgView addSubview:contenLable];
    
    UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake(WIDETH-35, 12, 20, 20)];
    imageView.image = [UIImage imageNamed:@"chashaixuan"];
    [bgView addSubview:imageView];
    bgView.backgroundColor = [UIColor whiteColor];
    return bgView;
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 42;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TH_JobScreenDetailVC * JobDetail =[[TH_JobScreenDetailVC alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            
                JobDetail.title = @"行业类别";
                JobDetail.titleText = @"请选择行业类别";
                JobDetail.DataArray = self.industryArray;
                [self.navigationController pushViewController:JobDetail animated:YES];
        }
            break;
            case 1:
        {
            JobDetail.title = @"职位大类";
            JobDetail.titleText = @"请选择职位大类";
            JobDetail.DataArray = self.industryArray;
            [self.navigationController pushViewController:JobDetail animated:YES];

            break;
        }
        case 2:
        {
            JobDetail.title = @"工作城市";
            JobDetail.titleText = @"请选择工作城市";
            JobDetail.DataArray = self.industryArray;
            [self.navigationController pushViewController:JobDetail animated:YES];

            break;
        }

        case 3:
        {JobDetail.title = @"薪资待遇";
            JobDetail.titleText = @"请选择你期望的薪资待遇";
            JobDetail.DataArray = self.industryArray;
            [self.navigationController pushViewController:JobDetail animated:YES];

            break;
        }

        case 4:
        {
            JobDetail.title = @"学历要求";
            JobDetail.titleText = @"请选择职位要求的学历";
            JobDetail.DataArray = self.industryArray;
            [self.navigationController pushViewController:JobDetail animated:YES];

            break;
        }

        case 5:
        {JobDetail.title = @"工作经验";
            JobDetail.titleText = @"请选择职位要求的工作经验";
            JobDetail.DataArray = self.industryArray;
            [self.navigationController pushViewController:JobDetail animated:YES];

            break;
        }
        case 6:
        {
            JobDetail.title = @"工作类型";
            JobDetail.titleText = @"请选择你期望的工作类型";
            JobDetail.DataArray = self.industryArray;
            [self.navigationController pushViewController:JobDetail animated:YES];

            break;
        }
        case 7:
        {
            JobDetail.title = @"发布时间";
            JobDetail.titleText = @"请选择职位发布时间";
            JobDetail.DataArray = self.industryArray;
            [self.navigationController pushViewController:JobDetail animated:YES];

            break;
        }
            
        default:
            break;
    }

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
