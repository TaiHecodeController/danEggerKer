//
//  EnterpriseView.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "EnterpriseView.h"

@implementation EnterpriseView

+(EnterpriseView*)setEnterpriseView
{

    return [[[NSBundle mainBundle] loadNibNamed:@"Enterprise" owner:self options:nil] lastObject];
}
-(void)setEnterpriseValue
{
    self.ReceiveResumeLable.tag = THEnterpriseTypeReceiveResumeLable;
    self.talentPoolBtn.tag = THEnterpriseTypeTalentPoolBtn;
    self.allPositionBtn.tag = THEnterpriseTypeAllPositionBtn;
    self.recruitmentPositionBtn.tag = THEnterpriseTypeRecruitmentPositionBtn;
    self.outDatePosionBtn.tag = THEnterpriseTypeOutDatePosionBtn;
    

}
- (IBAction)btnClick:(UIButton *)sender {
    
    if ([self.enterDelegate respondsToSelector:@selector(enterprise:DidClickButton:)]) {
        [self.enterDelegate enterprise:self DidClickButton:(THEnterpriseType)sender.tag];
    }
}

@end
