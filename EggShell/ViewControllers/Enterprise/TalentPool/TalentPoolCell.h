//
//  TalentPoolCell.h
//  EggShell
//

#import <UIKit/UIKit.h>

//#import "cpy_ReciveResumeListMode.h"
#import "TalentModel.h"

@interface TalentPoolCell : UITableViewCell

@property (nonatomic, strong) UIButton *selIcon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *positionLab;
@property (nonatomic, strong) UILabel *expLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *salaryLab;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, copy) NSString *icon_seleted;

- (void)config:(TalentModel *)model;

@end

