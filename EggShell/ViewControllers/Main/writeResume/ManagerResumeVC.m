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
#import "ResumeModel.h"
@interface ManagerResumeVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UIView * _alertView;
    UIView * bgView;
    ResumeModel * _resume_model;
}

@property (strong,nonatomic)NSMutableArray * dataArray;
@property (strong,nonatomic)NSMutableArray * cellArray;
@property (nonatomic, strong) ResumeCell *varCell;
@property (nonatomic, strong) NSMutableString *deleteStr;
@end

@implementation ManagerResumeVC

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"managerresumevc"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"manegerresumevc"];
    
    [self.cellArray removeAllObjects];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"简历管理";
    self.ResumeList.tableFooterView = [[UIView alloc] init];
    self.ResumeList.scrollEnabled = NO;
    _resume_model = [ResumeModel sharedResume];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.cellArray = [NSMutableArray arrayWithCapacity:0];
    
}

-(void)loadData
{
    MBProgressHUD * hub = [MBProgressHUD mbHubShowControllerView:self];
    [[WriteResumeRequest getResumeListWithSucc:^(NSArray * DataArray) {
        self.dataArray = [NSMutableArray arrayWithArray:DataArray];
        if(self.dataArray.count == 0)
        {
            [MBProgressHUD creatembHub:@"暂时还没有简历,快来创建你的第一份简历吧"];
            self.resumeNumberLab.text = [NSString stringWithFormat:@"%lu个",(unsigned long)self.dataArray.count];
            [self.ResumeList reloadData];
            
        }
        else if (self.dataArray.count < 5)
        {
            ManagerResumeModel * model = self.dataArray[0];
            [AppDelegate instance].resumeId = model.rid;
            _resume_model.resumeName = model.name;
//            self.createNewResume.alpha = 0.5;
            [self.ResumeList reloadData];
            
            self.resumeNumberLab.text = [NSString stringWithFormat:@"%lu个",(unsigned long)self.dataArray.count];
            
        }
        else
        {
            self.resumeNumberLab.text = [NSString stringWithFormat:@"%lu个",(unsigned long)self.dataArray.count];
            self.createNewResume.alpha = 0.5;
            [self.ResumeList reloadData];
        }
        
    } WithUserId:[AppDelegate instance].userId resp:[ManagerResumeModel class]] addNotifaction:hub];
}
- (IBAction)createNewResume:(UIButton *)sender {
    if(self.dataArray.count  < 5)
    {
        WriteResumeViewController * write = [[WriteResumeViewController alloc] init];
        write.isEdit = NO;
        [self.navigationController pushViewController:write animated:YES];
    }
    else
    {
        //简历等于5时候，不让创建简历
        [MBProgressHUD creatembHub:@"当前只能创建五份简历"];
        return;
    }
    
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
//    cell.createDate.text = model.ctime;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[model.ctime integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    cell.createDate.text = [formatter stringFromDate:confromTimesp];

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
        _varCell = cell;
    }
    [self.cellArray addObject:cell];
    return cell;
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

#pragma mark -- respondEvent
- (IBAction)delete:(id)sender {
    int index = 0;
    if (self.dataArray.count == 0)
    {
        [MBProgressHUD creatembHub:@"请先创建简历"];
    }
    
    for(int i = 0;i < self.dataArray.count;i++)
    {
        ResumeCell * cell = self.cellArray[i];
        if(cell.iSSelect.selected)
        {
            if (index == 0)
            {
                UIAlertView * aletview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
                aletview.delegate = self;
                [aletview show];
                index++;
            }
            else
            {
                
            }
            
        }else
        {
            [MBProgressHUD creatembHub:@"请选择要删除的简历"];
        }
        
    }
    
}

- (IBAction)editClick:(UIButton *)sender {
    
    //index用来记录是否勾选了简历 index=1时，是选择了一份简历；index=0时，是没有选择简历；index大于1时，是选择了多份简历；依据index做出相应提示。
    int index = 0;
    
    NSString *resumeid;
    for(int i = 0;i < self.dataArray.count;i++)
    {
        ResumeCell * cell = self.cellArray[i];
        if(cell.iSSelect.selected)
        {
            index++;
            resumeid = cell.resumeId;

        }
    }
    
    
    if (index != 0)
    {
        if (index == 1)
        {
            WriteResumeViewController * vc = [[WriteResumeViewController alloc] init];
            vc.resumeId = resumeid;
            vc.isEdit = YES;
            [AppDelegate instance].resumeId = resumeid;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [MBProgressHUD creatembHub:@"只能选择一份简历进行编辑"];
        }
    }
    
    if (index==0) {
        
            [MBProgressHUD creatembHub:@"请选择要编辑的简历"];
    }
    
    if (self.dataArray.count == 0)
    {
        [MBProgressHUD creatembHub:@"请先创建简历"];
    }
    
}
#pragma mark -- 使用简历
- (IBAction)userResume:(UIButton *)sender {
    
    if (self.dataArray.count == 0)
    {
        [MBProgressHUD creatembHub:@"请先创建简历"];
    }
    else
    {
//        if (_varCell)
//        {
//            if (_varCell.iSSelect.selected == YES)
//            {
//                [MBProgressHUD creatembHub:@"使用成功"];
//                _varCell.resumeId;
//                
//                NSLog(@"%@",_varCell.resumeId);
//                
//            }
//            else
//            {
//                [MBProgressHUD creatembHub:@"请先选择简历"];
//            }
//        }
//        else
//        {
//            return;
//        }
        //用来判定选择的是否是一个简历
        int index = 0;
        NSString *resumeid;
        for(int i = 0;i < self.dataArray.count;i++)
        {
            ResumeCell *cell = self.cellArray[i];
            if(cell.iSSelect.selected)
            {
//                NSLog(@"%@",cell.resumeId);
                index++;
                resumeid = cell.resumeId;
            }
            
        }
        
        if (index == 1)
        {
            NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
            NSDictionary *param = @{@"eid":resumeid,@"uid":[df objectForKey:@"uid"]};
            
            [WriteResumeRequest user_resumeWithSucc:^(NSDictionary *dataDic) {
                
                NSLog(@"%@",dataDic);
                [MBProgressHUD creatembHub:@"使用成功"];
                
            } withParam:param];
        }
        else
        {
            [MBProgressHUD creatembHub:@"请选择一份简历"];
        }


    }
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int index = 1;
    self.deleteStr = [[NSMutableString alloc]init];
    if (buttonIndex == 1)
    {
        for(int i = 0;i < self.dataArray.count;i++)
        {
            ResumeCell *cell = self.cellArray[i];
            if(cell.iSSelect.selected)
            {
                if (index == 1)
                {
                    [self.deleteStr appendFormat:[NSString stringWithFormat:@"%@",cell.resumeId]];
                    index++;
                }
                else
                {
                     [self.deleteStr appendFormat:[NSString stringWithFormat:@",%@",cell.resumeId]];
                }
                
            }
        }
        
        NSLog(@"%@",self.deleteStr);
         MBProgressHUD * hub = [MBProgressHUD mbHubShowControllerView:self];
        
        [[WriteResumeRequest deleteResumeWithSucc:^(NSDictionary *dataDic) {
            [MBProgressHUD creatembHub:@"删除成功"];
            
            [self.dataArray removeAllObjects];
            [self.cellArray removeAllObjects];
            self.deleteStr = [[NSMutableString alloc]init];;
            
            [self loadData];
            
            self.createNewResume.alpha = 1;
//            [self.ResumeList reloadData];
            
//            self.resumeNumberLab.text = [NSString stringWithFormat:@"%lu个",(unsigned long)self.dataArray.count];
            
        } WithResumeParam:@{@"eid":self.deleteStr}] addNotifaction:hub];
        
    }
}
@end
