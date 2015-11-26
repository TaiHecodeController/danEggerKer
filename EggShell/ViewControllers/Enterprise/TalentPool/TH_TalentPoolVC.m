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
#define bottomHeight 48
@interface TH_TalentPoolVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *deletBtn;
@property (nonatomic, strong) UIButton *kuangIcon;
@property (nonatomic, strong) UILabel *allSelLab;
@property(nonatomic,strong)UITableView  * tableView;
@end

@implementation TH_TalentPoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人才库";
    
    [self createTableView];
    [self addBottomView];
   
}
-(void)createTableView
{
    UITableView *  tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT - 64-bottomHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.backgroundColor = color(240, 240, 237);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   TalentPoolCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[TalentPoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67* MyWideth;
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
    _deletBtn.frame = CGRectMake((WIDETH - 195) / 2, 9, 195 * MyWideth, 30 * MyWideth);
    [_deletBtn addTarget:self action:@selector(deletBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_deletBtn];
    
    _kuangIcon = [[UIButton alloc]init];
    _kuangIcon.frame = CGRectMake(10, 5, 37 * MyWideth, 37 * MyWideth);
    [_kuangIcon setBackgroundImage:[UIImage imageNamed:@"duikuang001"] forState:UIControlStateNormal];
    [_kuangIcon setBackgroundImage:[UIImage imageNamed:@"duikuang123"] forState:UIControlStateSelected];
    [_kuangIcon addTarget:self action:@selector(all_Click:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_kuangIcon];
    
    _allSelLab = [[UILabel alloc]init];
    _allSelLab.text = @"全选";
    _allSelLab.font = [UIFont systemFontOfSize:13 * MyWideth];
    CGSize allSelSize = [_allSelLab.text sizeWithFont:_allSelLab.font];
    _allSelLab.frame = CGRectMake(CGRectGetMaxX(_kuangIcon.frame), 17.5, allSelSize.width, allSelSize.height);
    [_bottomView addSubview:_allSelLab];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }


@end
