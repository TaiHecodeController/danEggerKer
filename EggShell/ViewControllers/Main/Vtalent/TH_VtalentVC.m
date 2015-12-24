//
//  TH_VtalentVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/20.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_VtalentVC.h"
#import "TH_VtalentDetailVC.h"
@interface TH_VtalentVC ()
{
    int height;
}
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,strong)NSArray * elitearray;
@property(nonatomic,strong)NSArray * ambassadorArray;
@property(nonatomic,strong)UIScrollView * scro;

@end

@implementation TH_VtalentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scro];
    self.title = @"V达人";
    self.view.backgroundColor = [UIColor whiteColor];
    //蛋壳儿精英
    [self createEggerElite];
    [self loadData];
}
-(void)loadData
{
    
 [[TH_AFRequestState eggshellAmbassadorWithSucc:^(NSDictionary *arr) {
    
     self.dataDic = arr[@"data"];
     [self createEggerElite];
} withd:nil]addNotifaction:[MBProgressHUD mbHubShowControllerView:self] ];
    

}
-(void)createEggerElite
{
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 15)];
    titleLable.text = @"蛋壳精英";
    titleLable.font = [UIFont systemFontOfSize:15*MyWideth];
    titleLable.textColor = UIColorFromRGB(0x323232);
    [self.scro addSubview:titleLable];
    self.elitearray = self.dataDic[@"Elite"];
    for (int i = 0 ; i <  self.elitearray.count; i++) {
        UIView * eliteBgVieW = [[UIView alloc] initWithFrame:CGRectMake(10+((WIDETH - 40)/3.0)*i+10*i, 35,(WIDETH - 40)/3.0, 112*MyWideth)];
       
        [self.scro addSubview:eliteBgVieW];
        //精英点击事件
        UIButton * eliteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (WIDETH - 40)/3.0, 112*MyWideth)];
        eliteBtn.tag = 10+i;
        [eliteBgVieW addSubview:eliteBtn];
        [eliteBtn addTarget:self action:@selector(eliteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //精英头像
        UIImageView * eliteImageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, eliteBgVieW.frame.size.width, 63*MyWideth)];
//         eliteImageVeiw.image =[UIImage imageNamed:@"dashi"];
        [eliteImageVeiw sd_setImageWithURL:[NSURL URLWithString:self.elitearray[i][@"studentsphoto"]] placeholderImage:[UIImage imageNamed:@"tu"]];
        [eliteBgVieW addSubview:eliteImageVeiw];
        //精英姓名
        UILabel * eliteNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, eliteImageVeiw.frame.size.height +10*MyWideth, (WIDETH - 40)/3.0, 14*MyWideth)];
        eliteNameLable.text =   self.elitearray[i][@"studentsname"];
        eliteNameLable.textColor = UIColorFromRGB(0x323232);
        eliteNameLable.font =[UIFont systemFontOfSize:14*MyWideth];
        [eliteBgVieW addSubview:eliteNameLable];
        //精英类型
        UILabel * eliteNatureLable =[[UILabel alloc] initWithFrame:CGRectMake(0, eliteImageVeiw.frame.size.height +10*MyWideth+14*MyWideth+5*MyWideth, (WIDETH - 40)/3.0, 13*MyWideth)];
        eliteNatureLable.text =  self.elitearray[i][@"motto"];
        eliteNatureLable.font = [UIFont systemFontOfSize:13*MyWideth];
        eliteNatureLable.textColor = UIColorFromRGB(0x646464);
        [eliteBgVieW addSubview:eliteNatureLable];
        
    }
    
    //分割线
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 35+112*MyWideth, WIDETH, 10)];
    lineView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self.scro addSubview:lineView];
    //蛋壳儿大使
    UILabel * ambassadorLalbe = [[UILabel alloc] initWithFrame:CGRectMake(10, 35+112*MyWideth+20, 150, 15)];
    ambassadorLalbe.text = @"蛋壳大使";
    ambassadorLalbe.font = [UIFont systemFontOfSize:15*MyWideth];
    ambassadorLalbe.textColor = UIColorFromRGB(0x323232);
    [self.scro addSubview:ambassadorLalbe];
    
    self.ambassadorArray = self.dataDic[@"Envoy"];

    for (int i = 0 ; i < self.ambassadorArray.count; i++) {
        UIView * ambassadorView = [[UIView alloc] initWithFrame:CGRectMake(10+((WIDETH-35)/2.0)*(i/2)+15*(i/2), 112*MyWideth+80+(135*MyWideth)*(i%2)+10*(i%2), (WIDETH-35)/2.0, 135*MyWideth)];
        [self.scro addSubview:ambassadorView];
        
        //大使点击事件
        UIButton * ambassadorButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, (WIDETH-35)/2.0, 135*MyWideth) ];
        [ambassadorButton addTarget:self action:@selector(ambassadorButton:) forControlEvents:UIControlEventTouchUpInside];
        ambassadorButton.tag = 10+i;
        [ambassadorView addSubview:ambassadorButton];
        //大使头像
        UIImageView * ambassadorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ambassadorView.frame.size.width, 96*MyWideth)];
//        ambassadorImageView.image =[UIImage imageNamed:@"dashi"];
        [ambassadorImageView sd_setImageWithURL:[NSURL URLWithString:self.ambassadorArray[i][@"studentsphoto"]] placeholderImage:[UIImage imageNamed:@"tu"]];
        [ambassadorView addSubview:ambassadorImageView];
        //大使姓名
        UILabel * ambassadorNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, ambassadorImageView.frame.size.height+10*MyWideth, (WIDETH-35)/2.0, 14*MyWideth)];
        ambassadorNameLable.font = [UIFont systemFontOfSize:14*MyWideth];
//        ambassadorNameLable.text = @"蛋壳大使";
        ambassadorNameLable.text = self.ambassadorArray[i][@"studentsname"];
        ambassadorNameLable.textColor = UIColorFromRGB(0x323232);        [ambassadorView addSubview:ambassadorNameLable];
        //大使类型
        UILabel * ambassadorAutureLable = [[UILabel alloc] initWithFrame:CGRectMake(0, ambassadorImageView.frame.size.height+10*MyWideth+5*MyWideth+14*MyWideth, (WIDETH-35)/2.0, 13*MyWideth)];
//        ambassadorAutureLable.numberOfLines = 0;
        ambassadorAutureLable.font = [UIFont systemFontOfSize:13*MyWideth];
        ambassadorAutureLable.textColor = UIColorFromRGB(0x646464);
//        ambassadorAutureLable.text = @"蛋壳明星大使";
        ambassadorAutureLable.text = self.ambassadorArray[i][@"motto"];
        [ambassadorView addSubview:ambassadorAutureLable];
        //判断题
        int count2 ;
        if([[NSString stringWithFormat:@"%d",(int)(self.ambassadorArray.count % 2)] isEqual:[NSString stringWithFormat:@"%d",0]])
        {
            count2 = (int)self.ambassadorArray.count/2;
            
            
        }else
        {
            count2 = (int)self.ambassadorArray.count/2+1;
        }
        
        height = (135*MyWideth)*count2+10*count2;
    }
    
    
    self.scro.contentSize = CGSizeMake(WIDETH, 112*MyWideth+80+height+80);
    
                                                                          
}
-(void)eliteBtnClick:(UIButton*)sender

{ int i = (int)sender.tag-10;
    TH_VtalentDetailVC * talentDetail = [[TH_VtalentDetailVC alloc] init];
      talentDetail.dataDic =  self.elitearray[i];
    [self.navigationController pushViewController:talentDetail animated:YES];
}
-(void)ambassadorButton:(UIButton*)sender
{ TH_VtalentDetailVC * talentDetail = [[TH_VtalentDetailVC alloc] init];
    talentDetail.dataDic = self.ambassadorArray[sender.tag - 10];
    [self.navigationController pushViewController:talentDetail animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
@end
