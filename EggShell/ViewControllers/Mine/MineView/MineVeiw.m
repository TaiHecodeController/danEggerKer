//
//  MineVeiw.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "MineVeiw.h"
@interface MineVeiw()
@property (weak, nonatomic) IBOutlet UIButton *HeadPortraitBtn;
@property (weak, nonatomic) IBOutlet UIButton *EditInformationBtn;
@property (weak, nonatomic) IBOutlet UIButton *DeliveryJobsBtn;
@property (weak, nonatomic) IBOutlet UIButton *CollectionJobs;
@property (weak, nonatomic) IBOutlet UIButton *Resume;
@property (weak, nonatomic) IBOutlet UIButton *AboutEggshellBtn;
@property (weak, nonatomic) IBOutlet UIButton *ChannelsCooperation;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *Feedback;
@property (weak, nonatomic) IBOutlet UIButton *chatNewVersion;
@property (weak, nonatomic) IBOutlet UIButton *signOut;
@property (weak, nonatomic) IBOutlet UIButton *completionActivity;
@property (weak, nonatomic) IBOutlet UIButton *collectionActivity;

@end
@implementation MineVeiw
-(void)mineViewSetButtonTag;

{
    self.HeadPortraitBtn.layer.cornerRadius  = 25;
    self.HeadPortraitBtn.layer.masksToBounds = YES;
    self.HeadPortraitBtn.layer.borderWidth = 1;
    self.HeadPortraitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.HeadPortraitBtn.tag  = THMineViewButtonTypeHeadPortraitBtn;
    self.EditInformationBtn.tag = THMineViewButtonTypeEditInformationBtn;
    self.DeliveryJobsBtn.tag = THMineViewButtonTypeDeliveryJobsBtn;
    self.CollectionJobs.tag = THMineViewButtonTypeCollectionJobs;
    self.Resume.tag = THMineViewButtonTypeResume;
    self.AboutEggshellBtn.tag = THMineViewButtonTypeAboutEggshellBtn;
    self.ChannelsCooperation.tag = THMineViewButtonTypeChannelsCooperation;
    self.signOut.tag =  THMineViewButtonTypesignOut;
    self.loginBtn.tag = THMineViewButtonTypeLogin;
    self.Feedback.tag = THMineViewButtonTypeFeedback;
    self.chatNewVersion.tag = THMineViewButtonTypeversion;
    self.completionActivity.tag = THMineViewButtonTypecompletionActivity;
    self.collectionActivity.tag = THMineViewButtonTypecollectionActivity;
   
}

+(MineVeiw*)RegisterMineView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MineView" owner:self options:nil] lastObject];
    
}

- (IBAction)mineViewBtnClick:(UIButton*)sender {
    
    
    if ([self.mineDelegate respondsToSelector:@selector(homeView:DidClickButton:)]) {
    [self.mineDelegate homeView:self DidClickButton:(THMineViewButtonType)sender.tag];
        NSLog(@"");
        
        }
}
- (void)setIconImage:(UIImage *)image
{
    [self.HeadPortraitBtn setImage:image forState:UIControlStateNormal];
    
}

@end
