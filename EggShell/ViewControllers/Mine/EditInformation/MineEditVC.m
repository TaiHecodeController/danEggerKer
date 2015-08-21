//
//  MineEditVC.m
//  EggShell
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "MineEditVC.h"
#import "MineEditInfoView.h"
#import "EditAddressVC.h"
#import "MineEditInfoCell.h"

@interface MineEditVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIScrollView * backView;
    UITextField * recordTextField;
}
@property (strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property (strong,nonatomic)NSMutableArray * jobCellArray;

@property (strong,nonatomic)NSArray * nameArray2;
@property (strong,nonatomic)NSArray * holderArray2;
@property (strong,nonatomic)NSMutableArray * jobCellArray2;

@property (strong,nonatomic)NSArray * nameArray3;
@property (strong,nonatomic)NSArray * holderArray3;
@property (strong,nonatomic)NSMutableArray * jobCellArray3;
@end

@implementation MineEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    self.jobCellArray = [NSMutableArray arrayWithCapacity:0];
    [self addNotifacation];
    [self createData];
    [self createUI];
    [self createNav];
    // Do any additional setup after loading the view.
}

-(void)addNotifacation
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyBoardHide
{
    backView.contentSize = CGSizeMake(WIDETH / 2, HEIGHT + 60);
    [backView scrollRectToVisible:[UIScreen mainScreen].bounds animated:YES];
}

-(void)createData
{
    self.nameArray = @[@"登陆账号",@"昵称",@"性别",@"所在地",@"简介"];
    self.holderArray = @[@"18800006666",@"王鑫",@"男",@"北京",@"学习是一种信仰"];
    
    self.nameArray2 = @[@"生日",@"邮箱",@"QQ"];
    self.holderArray2 = @[@"2015-7-10",@"",@""];
    
    self.nameArray3 = @[@"等级",@"注册时间"];
    self.holderArray3 = @[@"",@"2015-8-2"];
}


-(void)createUI
{
    backView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.contentSize = CGSizeMake(WIDETH / 2, HEIGHT + 60);
    backView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    [self.view addSubview:backView];
    
    //上方tableView
    UITableView * tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 210)];
    tableView1.tag = 1222;
    tableView1.scrollEnabled = NO;
    tableView1.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    tableView1.layer.borderWidth = 0.5;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [backView addSubview:tableView1];
    
    //中间tableView
    UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 230, WIDETH, 126)];
    tableView2.tag = 1223;
    tableView2.scrollEnabled = NO;
    tableView2.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    tableView2.layer.borderWidth = 0.5;
    tableView2.delegate = self;
    tableView2.dataSource = self;
    [backView addSubview:tableView2];
    
    //底部tableView
    UITableView * tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 376, WIDETH, 84)];
    tableView3.tag = 1224;
    tableView3.scrollEnabled = NO;
    tableView3.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    tableView3.layer.borderWidth = 0.5;
    tableView3.delegate = self;
    tableView3.dataSource = self;
    [backView addSubview:tableView3];

    
    
}

-(void)tap
{
    [recordTextField resignFirstResponder];
}

-(void)createNav
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1222)
    {
        return 5;
    }
    if(tableView.tag == 1223)
    {
        return 3;
    }
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1222)
    {
        MineEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineEditInfoCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentTextField.delegate = self;
        }
        
        cell.nextBtn.hidden = YES;
        cell.showAllBtn.hidden = YES;
        cell.moreLab.hidden = YES;
        cell.Controller = self;
        if(indexPath.row == 2)
        {
            cell.showAllBtn.hidden = NO;
            cell.showAllBtn.tag = 200 + 2;
        }
        if(indexPath.row == 3)
        {
            cell.nextBtn.hidden = NO;
        }
        if(indexPath.row == 5)
        {
            cell.moreLab.hidden = NO;
        }
        cell.nameLab.text = self.nameArray[indexPath.row];
        cell.contentTextField.text = self.holderArray[indexPath.row];
        [self.jobCellArray addObject:cell];
        return cell;
    }
    
    if(tableView.tag == 1223)
    {
        MineEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID2"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineEditInfoCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentTextField.delegate = self;
            cell.contentTextField.tag = 400 + indexPath.row;
        }
        cell.Controller = self;
        cell.nextBtn.hidden = YES;
        cell.showAllBtn.hidden = YES;
        cell.moreLab.hidden = YES;
        cell.nameLab.text = self.nameArray2[indexPath.row];
        cell.contentTextField.text = self.holderArray2[indexPath.row];
        if(indexPath.row == 0)
        {
            cell.showAllBtn.hidden = NO;
            cell.showAllBtn.tag = 200;
        }
        [self.jobCellArray addObject:cell];
        return cell;
        
    }
    
    if(tableView.tag == 1224)
    {
        MineEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID3"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineEditInfoCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentTextField.delegate = self;
            cell.contentTextField.tag = 500 + indexPath.row;
        }
        cell.Controller = self;
        cell.nextBtn.hidden = YES;
        cell.showAllBtn.hidden = YES;
        cell.moreLab.hidden = YES;
        cell.nameLab.text = self.nameArray3[indexPath.row];
        cell.contentTextField.text = self.holderArray3[indexPath.row];
        [self.jobCellArray addObject:cell];
        return cell;
    }

    
    return nil;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag >= 400)
    {
        if(HEIGHT == 480)
        {
            backView.contentSize = CGSizeMake(WIDETH, HEIGHT + 280);
            [backView scrollRectToVisible:CGRectMake(0, 280, WIDETH, HEIGHT) animated:YES];
        }else
        {
            backView.contentSize = CGSizeMake(WIDETH, HEIGHT + 210);
            [backView scrollRectToVisible:CGRectMake(0, 210, WIDETH, HEIGHT) animated:YES];
        }
        
    }
    recordTextField = textField;
}

-(void)rightClick:(UIButton *)sender
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
