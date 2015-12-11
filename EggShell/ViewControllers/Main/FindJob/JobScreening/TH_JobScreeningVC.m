//
//  TH_JobScreeningVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/17.
//  Copyright (c) 2015年 wsd. All rights reserved.
//  条件搜索选项界面

#import "TH_JobScreeningVC.h"
#import "JobScreeningCell.h"
#import "TH_JobScreenDetailVC.h"
#import "WriteResumeRequest.h"
#import "WriteJLChooseVC.h"
#import "SearchModelShare.h"
#import "SearchCity1_ViewController.h"
#import "SearchCity2_ViewController.h"
#import "SearchCity3_ViewController.h"
#import "TH_FindJobVC.h"

@interface TH_JobScreeningVC ()<UITableViewDataSource,UITableViewDelegate,writeJLChooseVCDelegate,SearchCity3_VCDelegate3,UITextFieldDelegate,SearchCity2_VCDelegate2>
@property(nonatomic,strong)NSArray * nameArray;
@property(nonatomic,strong)NSArray * conrentArray;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)JobScreeningCell *cell;
@property(nonatomic,strong)NSMutableArray * cellArray;
/*类别的选择**/
@property(nonatomic,strong)NSDictionary * categaryDic;
@property (nonatomic, strong)UITextField *keywordTextfield;
@property(nonatomic,strong)UITextField * contenLable;
@end

@implementation TH_JobScreeningVC

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"jobscreeningvc"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"jobscreeningvc"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearParam];
    
    self.cellArray = [NSMutableArray arrayWithCapacity:0];
    [self createSco];
    [self setData];
    [self creatableView];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self InquireBtn];
    
    [self loadData];
}

- (void)clearParam
{
    //进入页面，清空所有筛选条件，防止上一次的筛选条件，影响下一次筛选结果
    [SearchModelShare sharedInstance].keyword = @"";
    
    [SearchModelShare sharedInstance].hy = @"";
    
    [SearchModelShare sharedInstance].job_post = @"";
    
    [SearchModelShare sharedInstance].cityid = @"";
    
    [SearchModelShare sharedInstance].salary = @"";
    
    [SearchModelShare sharedInstance].edu = @"";
    
    [SearchModelShare sharedInstance].exp = @"";
    [SearchModelShare sharedInstance].provinceid = @"";

    //清空工作性质，防止从首页进来，type有值，但是筛选页面没有选type值，首页的type值就会影响筛选结果
    [SearchModelShare sharedInstance].type = @"";
    
    [SearchModelShare sharedInstance].sdate = @"";

}

-(void)loadData
{
    [[WriteResumeRequest getSearchJobMessageListWithSucc:^(NSDictionary *DataDic) {
        self.categaryDic = DataDic[@"data"];
    }] addNotifaction:[MBProgressHUD mbHubShow]];
}
-(void)setData
{
    self.nameArray = @[@"行业类别",@"职位类别",@"工作城市",@"薪资待遇",@"学历要求",@"工作经验",@"工作类型",@"发布时间"];
    
//    self.conrentArray = @[@"计算机/互联网",@"技术人员/助理",@"北京",@"3000-10000",@"本科",@"3年",@"全职",@"一天内"];
    self.conrentArray = @[@"",@"",@"北京",@"",@"",@"",@"",@""];
    
//    self.industryArray = @[@"不限",@"计算机/互联网",@"机械/设备/技工",@"贸易/百货",@"化工/能源",@"公务员/翻译/其他",@"服务业",@"咨询/法律/教育/科研",@"人事/行政/高级管理",@"建筑/房地产",@"广告/市场/媒体/艺术",@"生物/制药/医疗/护理",@"生产/营运/采购/物流",@"会计/金融/银行/保险",@"销售/客服/技术支持",@"信息/电子"];
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
    cell.contentTextFiled.placeholder  = self.conrentArray[indexPath.row];
    cell.contentTextFiled.userInteractionEnabled = NO;
    cell.contentTextFiled.textColor = [UIColor blackColor];
    [self.cellArray addObject:cell];
    self.cell = cell;
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 42)];
    
    UILabel * CategorieLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15,60, 13)];
    CategorieLable.text = @"关键字";
    CategorieLable.font =[UIFont systemFontOfSize:13];
    [bgView addSubview:CategorieLable];
    
//    UILabel * contenLable =[[UILabel alloc] initWithFrame:CGRectMake(100, 15, WIDETH-165, 13)];
//    contenLable.text = [SearchModelShare sharedInstance].keyword;
//    contenLable.font =[UIFont systemFontOfSize:13];
//    contenLable.textAlignment = NSTextAlignmentRight;
//    UIView * lineView =[[UIView alloc] initWithFrame:CGRectMake(15, 41.5, WIDETH-15, 0.5)];
//    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
//    [bgView addSubview:lineView];
//    [bgView addSubview:contenLable];
    UITextField * contenLable =[[UITextField alloc] initWithFrame:CGRectMake(100, 8, WIDETH-165, 26)];
//    contenLable.text = [SearchModelShare sharedInstance].keyword;
    contenLable.font =[UIFont systemFontOfSize:13];
    contenLable.placeholder = @"输入关键字，例:工程师";
    contenLable.textColor = [UIColor blackColor];
    contenLable.textAlignment = NSTextAlignmentRight;
    UIView * lineView =[[UIView alloc] initWithFrame:CGRectMake(15, 41.5, WIDETH-15, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [bgView addSubview:lineView];
    [bgView addSubview:contenLable];
    self.contenLable = contenLable;
    contenLable.delegate = self;
    _keywordTextfield = contenLable;
    
 
    
    
    UIImage *img = [UIImage imageNamed:@"chazi"];
    UIImageView * imageView =[[UIImageView alloc] initWithFrame:CGRectMake(WIDETH-35, 8, img.size.width, img.size.height)];
    imageView.image = img;

    [bgView addSubview:imageView];
    bgView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearKeyWord)];
    [imageView addGestureRecognizer:tap];
    imageView.userInteractionEnabled = YES;
    
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
    
    switch (indexPath.row) {
        case 0:
        {
            
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"行业类别";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.categaryDic[@"hy"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
            
        }
            break;
            case 1:
        {
//            asfdasfasfasdfasdf
//            /**********     *************/
//            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
//            _writeJLChooseVC.delegete = self;
//            _writeJLChooseVC.titleText = @"职位类别";
//            _writeJLChooseVC.cellIndex = indexPath;
//            _writeJLChooseVC.tableViewTagIndex = 1555;
//            _writeJLChooseVC.DataArray = self.categaryDic[@"job_classid"];
//            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
            
            THLog(@"期望职位");
            SearchCity1_ViewController * _writeJLChooseVC = [[SearchCity1_ViewController alloc] init];
            //            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"期望职位";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            //存在user里
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            [df setObject:self.categaryDic[@"job_classid"] forKey:@"job_classid"];
            
            NSMutableArray *arr1 = [[NSMutableArray alloc]init];
            for (NSDictionary *dic in [df objectForKey:@"job_classid"])
            {
                if ([dic[@"keyid"] intValue] == 0 )
                {
                    [arr1 addObject:dic];
                }
            }
            _writeJLChooseVC.DataArray = arr1;
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];

            break;
        }
        case 2:
        {
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"工作城市";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.categaryDic[@"three_cityid"];
            
            _writeJLChooseVC.DataArray = [NSMutableArray arrayWithCapacity:0];
            
            NSString *  keyid = [[NSNumber numberWithInt:52] stringValue];
            NSString * province = [[NSNumber numberWithInt:2] stringValue];
            
            NSDictionary * dic = @{@"name":@"全城",@"keyid":keyid,@"id":province};
            [_writeJLChooseVC.DataArray addObject:dic];
            for (int i = 0; i < [self.categaryDic[@"three_cityid"]count]; i++) {
                
                [_writeJLChooseVC.DataArray addObject:self.categaryDic[@"three_cityid"][i]];
            }
            
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
            break;
        }

        case 3:
        {
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"薪资待遇";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.categaryDic[@"pay"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];

            break;
        }

        case 4:
        {

            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"学历要求";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.categaryDic[@"education"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
            break;
        }

        case 5:
        {
            
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"工作经验";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.categaryDic[@"experience"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];

            break;
        }
        case 6:
        {
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"工作类型";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.categaryDic[@"type"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];

            break;
        }
        case 7:
        {
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"发布时间";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.categaryDic[@"fbtime"];
            
            
            
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];

            break;
        }
            
        default:
            break;
    }

}

#pragma mark -- writeJLDelegate
- (void)chooseWord:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id
{

        JobScreeningCell *cell = (JobScreeningCell *)[self.tableView cellForRowAtIndexPath:cellIndex];
        cell.contentTextFiled.text = keyWord;
    NSLog(@"%ld",(long)cellIndex.row);
    
    if (cellIndex.row == 0)
    {
//        [SearchModelShare sharedInstance].job1 = Id;
        [SearchModelShare sharedInstance].hy = Id;
    }
    else if (cellIndex.row == 1)
    {
        [SearchModelShare sharedInstance].job_post = Id;
    }
    else if (cellIndex.row == 2)
    {
        NSLog(@"%ld",(long)tableViewTagIndex);
        
        if ([keyWord isEqualToString:@"全城"])
        {
        [SearchModelShare sharedInstance].provinceid = Id;
            
        }else
        {
        [SearchModelShare sharedInstance].cityid = Id;
            
            
        }
    }
    else if (cellIndex.row == 3)
    {
        
        [SearchModelShare sharedInstance].salary = Id;
        
    }
    else if (cellIndex.row == 4)
    {
        [SearchModelShare sharedInstance].edu = Id;
    }
    else if (cellIndex.row == 5)
    {
        [SearchModelShare sharedInstance].exp = Id;
    }
    else if (cellIndex.row == 6)
    {
        [SearchModelShare sharedInstance].type = Id;
    }
    else if (cellIndex.row == 7)
    {
        [SearchModelShare sharedInstance].sdate = Id;
        
        
        
    }
    
    

}

//- (void)chooseWord3:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id
//{
//        JobScreeningCell *cell = (JobScreeningCell *)[self.tableView cellForRowAtIndexPath:cellIndex];
//    cell.contentTextFiled.placeholder = keyWord;
//    [SearchModelShare sharedInstance].job_post = Id;
//}

#pragma mark -- respondEvent
- (void)clearKeyWord
{
    _keywordTextfield.text = @"";
    self.contenLable.placeholder = @"";
    [_keywordTextfield becomeFirstResponder];
    
}

#pragma mark -- SearchCityDelegate
//从三级分类返回数据
- (void)chooseWord3_SearchCity:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id
{
    JobScreeningCell *cell = (JobScreeningCell *)[self.tableView cellForRowAtIndexPath:cellIndex];
    cell.contentTextFiled.text = keyWord;
    [SearchModelShare sharedInstance].job_post = Id;
}
//当没有三级分类的时候，从二级分类返回数据
- (void)chooseWord2_SearchCity:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id
{
    JobScreeningCell *cell = (JobScreeningCell *)[self.tableView cellForRowAtIndexPath:cellIndex];
    cell.contentTextFiled.text = keyWord;
    [SearchModelShare sharedInstance].job_post = Id;
}

/*查询**/
-(void)inqireClick
{
    [SearchModelShare sharedInstance].keyword = _keywordTextfield.text;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TJsearch" object:nil];
    /**
     返回上一层时，刷新列表
     [[NSNotificationCenter defaultCenter] postNotificationName:@"TJsearch" object:nil];
     [self.navigationController popViewControllerAnimated:YES];
     */
   
    TH_FindJobVC *vc = [[TH_FindJobVC alloc]init];
    vc.rk_pushType = homePushType;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [SearchModelShare sharedInstance].keyword = textField.text;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
