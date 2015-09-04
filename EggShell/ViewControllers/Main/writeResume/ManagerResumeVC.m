//
//  ManagerResumeVC.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ManagerResumeVC.h"

#import "WriteResumeViewController.h"
#import "ResumeCell.h"
#import "WriteResumeRequest.h"
#import "AppDelegate.h"
#import "ManagerResumeModel.h"
@interface ManagerResumeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * _alertView;
    UIView * bgView;
    
}
@property (strong,nonatomic)NSMutableArray * dataArray;
@property (strong,nonatomic)NSMutableArray * cellArray;

@end

@implementation ManagerResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"简历管理";
    self.ResumeList.tableFooterView = [[UIView alloc] init];
    [self loadData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.cellArray = [NSMutableArray arrayWithCapacity:0];
    
}

-(void)loadData
{
    [WriteResumeRequest getResumeListWithSucc:^(NSArray * DataArray) {
        self.dataArray = [NSMutableArray arrayWithArray:DataArray];
        if(self.dataArray.count == 0)
        {
            [MBProgressHUD creatembHub:@"暂时还没有简历,快来创建你的第一份简历吧😄😄"];
        }else
        {
            ManagerResumeModel * model = self.dataArray[0];
            [AppDelegate instance].resumeId = model.rid;
            [self.ResumeList reloadData];
        }
    } WithUserId:[AppDelegate instance].userId resp:[ManagerResumeModel class]];
}
- (IBAction)createNewResume:(UIButton *)sender {
    
    WriteResumeViewController * write = [[WriteResumeViewController alloc] init];
    [self.navigationController pushViewController:write animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResumeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ResumeCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.Controller = self;
    cell.cellIndex = indexPath;
    ManagerResumeModel * model = self.dataArray[indexPath.row];
    cell.ResumeName.text = model.name;
    cell.createDate.text = model.ctime;
    cell.ResumeName.font = [UIFont systemFontOfSize:13];
    cell.resumeId = model.rid;
    cell.tag = 4000 + indexPath.row;
    cell.selectBlock = ^(int tag)
    {
        for(int i = 0;i < self.cellArray.count;i++)
        {
            ResumeCell * cell = self.cellArray[i];
            if(!cell.tag == tag)
            {
                cell.iSSelect.selected = NO;
            }
        }
    };
    if(indexPath.row == 0)
    {
        cell.iSSelect.selected = YES;
    }
    [self.cellArray addObject:cell];
    return cell;
}

//- (NSString *)flattenHTML:(NSString *)html {        NSScanner *theScanner;    NSString *text = nil;        theScanner = [NSScanner scannerWithString:html];        while ([theScanner isAtEnd] == NO) {        // find start of tag        [theScanner scanUpToString:@"<" intoString:NULL] ;        // find end of tag        [theScanner scanUpToString:@">" intoString:&text] ;        // replace the found tag with a space        //(you can filter multi-spaces out later if you wish)        html = [html stringByReplacingOccurrencesOfString:                [NSString stringWithFormat:@"%@>", text]                                               withString:@""];    } // while //        NSLog(@"-----===%@",html);    return html;}




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

- (IBAction)createNewResumeClick:(UIButton *)sender {
    if(self.dataArray.count > 0)
    {
        [MBProgressHUD creatembHub:@"当前只能创建一份简历"];
        return;
    }
}

- (IBAction)editClick:(UIButton *)sender {
}
- (IBAction)userResume:(UIButton *)sender {
    [self addAlertView];
}

- (void)addAlertView
{
    bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    CGFloat margin = 10;
    
    UIImage *bgimg = [UIImage imageNamed:@"shenqing"];
    CGFloat alertViewX = (WIDETH - bgimg.size.width) / 2;
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(alertViewX, -bgimg.size.height, bgimg.size.width, bgimg.size.height)];
    alertView.backgroundColor = [UIColor colorWithPatternImage:bgimg];
    [self.view addSubview:alertView];
    _alertView = alertView;
    
    
    
    UILabel *lab1 = [[UILabel alloc]init];
    lab1.text = @"申请职位";
    lab1.textColor =[UIColor whiteColor];
    lab1.font = [UIFont systemFontOfSize:13];
    CGSize labSize = [lab1.text sizeWithFont:lab1.font];
    lab1.frame = CGRectMake(margin, margin, labSize.width, labSize.height);
    [alertView addSubview:lab1];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    CGFloat closeWith = 10;
    closeBtn.frame = CGRectMake(alertView.frame.size.width - margin - closeWith, margin, closeWith, closeWith);
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeBtn];
    
    UITextView *jianliBtn = [[UITextView alloc]init];
    jianliBtn.text = [NSString stringWithFormat:@"使用"];
    jianliBtn.font = [UIFont systemFontOfSize:13];
    jianliBtn.frame = CGRectMake(margin, 40, 300, 50);
    [alertView addSubview:jianliBtn];
    
    UILabel * lab3 = [ZCControl createLabelWithFrame:CGRectMake(31, 1, 120, 30) Font:13 Text:@"个人简历001"];
    lab3.textColor = [UIColor redColor];
    [jianliBtn addSubview:lab3];
    
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.backgroundColor = color(63, 172, 241);
    CGFloat okBtnW =( 1- 0.34 * 2) * alertView.frame.size.width;
    okBtn.frame = CGRectMake(0.34 * alertView.frame.size.width, 100 , okBtnW, 30);
    okBtn.clipsToBounds = YES;
    okBtn.layer.cornerRadius = 5;
    [okBtn addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:okBtn];
    
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        alertView.frame = CGRectMake(alertViewX, 145, bgimg.size.width, bgimg.size.height);
        alertView.transform = CGAffineTransformMakeRotation((45.0 * M_PI)/180.0f);
        
        [UIView animateWithDuration:0.1 delay:0.05 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            alertView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            
        }];
    } completion:^(BOOL finished) {
        
        

    }];
    
    
    
}

-(void)okBtn
{
    [_alertView removeFromSuperview];
    [bgView removeFromSuperview];
}

-(void)closeBtn
{
    [_alertView removeFromSuperview];
    [bgView removeFromSuperview];
}


- (IBAction)delete:(id)sender {
    for(int i = 0;i < self.dataArray.count;i++)
    {
        ResumeCell * cell = self.cellArray[i];
        if(cell.iSSelect.selected)
        {
            MBProgressHUD * hub = [MBProgressHUD mbHubShow];
            [[WriteResumeRequest deleteResumeWithSucc:^(NSDictionary *dataDic) {
                [self.dataArray removeObjectAtIndex:i];
                [self.ResumeList reloadData];
            } WithResumeParam:@{@"eid":cell.resumeId}] addNotifaction:hub];
        }
        
    }
    
}
@end
