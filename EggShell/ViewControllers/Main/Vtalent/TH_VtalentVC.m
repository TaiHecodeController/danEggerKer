//
//  TH_VtalentVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/20.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_VtalentVC.h"

@interface TH_VtalentVC ()

@end

@implementation TH_VtalentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"V达人";
    //蛋壳儿精英
    [self createEggerElite];
}
-(void)createEggerElite
{
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 150, 35)];
    titleLable.text = @"蛋壳儿精英";
    titleLable.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleLable];
    for (int i = 0 ; i < 3; i++) {
        UIView * bgVieW = [[UIView alloc] initWithFrame:CGRectMake(15+((WIDETH - 70)/3.0)*i+20*i, 40,(WIDETH - 70)/3.0, (WIDETH - 70)/3.0)];
        bgVieW.backgroundColor =[UIColor redColor];
        [self.view addSubview:bgVieW];
    }
    //蛋壳儿大使
    UILabel * ambassadorLalbe = [[UILabel alloc] initWithFrame:CGRectMake(15, (WIDETH - 70)/3.0+70, 150, 35)];
    ambassadorLalbe.text = @"蛋壳儿大使";
    ambassadorLalbe.font =[UIFont systemFontOfSize:20];
    [self.view addSubview:ambassadorLalbe];
    
    for (int i = 0 ; i < 4; i++) {
        
        UIView * ambassadorView = [[UIView alloc] initWithFrame:CGRectMake(15+((WIDETH-60)/2.0)*(i/2)+30*(i/2), (WIDETH - 60)/3.0+100+((WIDETH-60)/2.0)*(i%2)+20*(i%2), (WIDETH-60)/2.0, (WIDETH-60)/2.0)];
        
        ambassadorView.backgroundColor =[UIColor blueColor];
        
        [self.view addSubview:ambassadorView];
    }
    
                                                                          
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
@end
