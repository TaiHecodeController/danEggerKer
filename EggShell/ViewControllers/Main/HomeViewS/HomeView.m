//
//  HomeView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/7.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "HomeView.h"
@interface HomeView()
//@property (weak, nonatomic) IBOutlet UIButton *FindJobBtn;
//@property (weak, nonatomic) IBOutlet UIButton *FindPartTimeBtn;
//
//@property (weak, nonatomic) IBOutlet UIButton *InternshipSearch;
//@property (weak, nonatomic) IBOutlet UIButton *InformationDesk;
//@property (weak, nonatomic) IBOutlet UIButton *ResumeWritingBtn;
//@property (weak, nonatomic) IBOutlet UIButton *PlayFan;
//@property (weak, nonatomic) IBOutlet UIButton *MicroSocialBtn;
//@property (weak, nonatomic) IBOutlet UIButton *OpenClassBtn;

@end
@implementation HomeView
+(instancetype)homeViewFinJob
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeViews" owner:self options:nil] lastObject];

}
//-(void)setHomeViewBtn
//{
//    self.FindJobBtn.tag       =      THHomeViewButtonTypeFindJob;
//    self.FindPartTimeBtn.tag  = THHomeViewButtonTypeFindPartTime;
//    self.InternshipSearch.tag = THHomeViewButtonTypeInternshipSearch;
//    self.InformationDesk.tag  = THHomeViewButtonTypeInformationDesk;
//    self.ResumeWritingBtn.tag = THHomeViewButtonTypeResumeWriting;
//    self.PlayFan.tag          = THHomeViewButtonTypePlayFan;
//    self.MicroSocialBtn.tag   = THHomeViewButtonTypeMicroSocial;
//    self.OpenClassBtn.tag     = THHomeViewButtonTypeOpenClass;
//       
//    
//    
//}
//- (IBAction)FindJobBtnClick:(UIButton *)sender {
//    if ([self.homeViewDelegate respondsToSelector:@selector(homeViewFindJob:DidClickButton:)]) {
//        [self.homeViewDelegate homeViewFindJob:self DidClickButton:(THHomeViewButtonType)sender.tag];
//    }
//}
- (IBAction)btnClick:(UIButton *)sender {
    [self.famousDelegate homeViewFindJob:self];
}

@end
