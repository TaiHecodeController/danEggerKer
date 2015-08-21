//
//  JobWishlistCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    JobButtontype
}typeBtn;
@class JobWishlistCell;
@protocol JobWishlistCellDeleDate <NSObject>

-(void)JobWishlistCellBtn:(JobWishlistCell*)jobCell didBtn:(typeBtn)sender;

@end
@interface JobWishlistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *jobBtn;

+(JobWishlistCell*)RegisterJobWishListCell;
-(void)sestbtn;
@property(nonatomic,strong)id<JobWishlistCellDeleDate>jobDeleGate;
@end
