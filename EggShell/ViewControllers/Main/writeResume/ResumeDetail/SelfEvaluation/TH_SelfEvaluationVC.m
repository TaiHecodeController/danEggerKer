//
//  TH_SelfEvaluationVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_SelfEvaluationVC.h"
#import "WriteRusumeModel2.h"
#import "WriteResumeRequest.h"
#import "AppDelegate.h"
@interface TH_SelfEvaluationVC ()
{
    WriteRusumeModel2 * _model;
}
@property (strong,nonatomic)UILabel * nameLab;
@property (strong,nonatomic)UITextView * contentTextField;
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation TH_SelfEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[WriteRusumeModel2 alloc] init];
    [self createScro];
    [self createView];

}
-(void)createScro
{
    self.view.backgroundColor = color(243, 243, 241);
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 243);
    [self.view addSubview:scro];
}

-(void)createView
{   UILabel * nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 15, 135, 13) Font:13 Text:@"个人简历001-自我评价"];
    [self.scro addSubview:nameLab];
    
    UIButton * stateBtn = [ZCControl createButtonWithFrame:CGRectMake(160, 9.5, 53, 23) ImageName:@"lanniu2" Target:self Action:nil Title:@"可选填"];
    [stateBtn setTitleColor:color(255, 255, 255) forState:UIControlStateNormal];
    stateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.scro addSubview:stateBtn];
    /*请输入相关内容**/
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, WIDETH, 160)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = color(221, 221, 221).CGColor;
    [self.scro addSubview:bgView];
    
    self.nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 50, 52, 21) Font:13 Text:@"自我评价"];
    [bgView addSubview:self.nameLab];
    
    UIView * line = [ZCControl viewWithFrame:CGRectMake(77, 46, 1, 26)];
    line.backgroundColor = color(203, 203, 203);
    [bgView addSubview:line];
    
    self.contentTextField = [[UITextView alloc] initWithFrame:CGRectMake(87,15, WIDETH - 101, 114)];
    self.contentTextField.font = [UIFont systemFontOfSize:13];
    
    self.contentTextField.textAlignment = NSTextAlignmentNatural;
    self.contentTextField.textColor = color(203, 203, 203);
    self.contentTextField.text = @"请填写自我评价";
    [bgView addSubview:self.contentTextField];
    /*按钮选项**/
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(75, 217, (WIDETH-150-18)/2.0, 30) ImageName:@"hongniu2" Target:self Action:@selector(saveBtnClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),217, (WIDETH-150-18)/2.0, 30) ImageName:@"lanniu2" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:replaceBtn];
}
/*保存**/
-(void)saveBtnClick
{
    if(self.contentTextField.text.length<30)
    {
        [MBProgressHUD creatembHub:@"请输入至少15个字符"];
        return;
    }else
    {
        _model.content = [self.contentTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    MBProgressHUD * hub = [MBProgressHUD mbHubShow];
    
    [[WriteResumeRequest uploadSelfEvaluationWithSucc:^(NSDictionary *dataDic) {
        [MBProgressHUD creatembHub:@"保存成功"];
    } WithResumeParam:@{@"uid":[AppDelegate instance].userId,@"eid":[AppDelegate instance].resumeId,@"content":_model.content}] addNotifaction:hub];
    
}
/*重置**/
-(void)replaceBtnClick
{
    self.contentTextField.text = @"请填写自我评价";
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.contentTextField resignFirstResponder];
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
