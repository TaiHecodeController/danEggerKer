//
//  HYSegmentedControl.m
//  CustomSegControlView
//
//  Created by sxzw on 14-6-12.
//  Copyright (c) 2014年 sxzw. All rights reserved.
//

#import "HYSegmentedControl.h"

#define HYSegmentedControl_Height 40.0
#define HYSegmentedControl_Width ([UIScreen mainScreen].bounds.size.width)
#define Min_Width_4_Button 160.0

#define Define_Tag_add 1000

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HYSegmentedControl()

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)NSMutableArray *array4Btn;
@property (strong, nonatomic)UIView *bottomLineView;

@end

@implementation HYSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles IconNames:(NSArray *)iconNames delegate:(id)delegate
{
    CGRect rect4View = CGRectMake(.0f, y, HYSegmentedControl_Width, HYSegmentedControl_Height);
    if (self = [super initWithFrame:rect4View]) {
        
//        self.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
        [self setUserInteractionEnabled:YES];
        
        self.delegate = delegate;
//        self.backgroundColor = backgroudColor;
        
        //
        //  array4btn
        //
        _array4Btn = [[NSMutableArray alloc] initWithCapacity:[titles count]];
        
        //
        //  set button
        //
        CGFloat margin = 50;
        
        CGFloat width4btn = (rect4View.size.width)/[titles count];
//        if (width4btn < Min_Width_4_Button) {
//            width4btn = Min_Width_4_Button;
//        }
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.contentSize = CGSizeMake([titles count]*width4btn, HYSegmentedControl_Height );
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i<[titles count]; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.backgroundColor = [UIColor redColor];
            btn.frame = CGRectMake(i*width4btn, - y, width4btn, HYSegmentedControl_Height);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            //设置标题颜色
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

            //设置图片颜色
            [btn setImage:[UIImage imageNamed:[[iconNames objectAtIndex:i] objectAtIndex:0]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[[iconNames objectAtIndex:i] objectAtIndex:1]] forState:UIControlStateSelected];
            
//            btn.layer.borderWidth = 1;
//            btn.layer.borderColor = [UIColor redColor].CGColor;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = Define_Tag_add+i;
            [_scrollView addSubview:btn];
            [_array4Btn addObject:btn];
            
            if (i == 0) {
                btn.selected = YES;
//                btn.backgroundColor = [UIColor redColor];
            }
            else
            {
//                btn.backgroundColor = [UIColor clearColor];
            }
        }
        
        //
        //  lineView
        //
        CGFloat height4Line = HYSegmentedControl_Height/3.0f;
        CGFloat originY = (HYSegmentedControl_Height - height4Line)/2;
        for (int i = 1; i<[titles count]; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*width4btn-1.0f, originY - 66, 1.0f, height4Line)];
            lineView.backgroundColor = UIColorFromRGBValue(0xcccccc);
//            [_scrollView addSubview:lineView];
        }
        
        //底线
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f,HYSegmentedControl_Height - 0.5 - y, [UIScreen  mainScreen].bounds.size.width, 0.5)];
        lineView1.backgroundColor = color(221, 221, 221);
        [_scrollView addSubview:lineView1];
        
        //中线
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake((WIDETH - 0.5) / 2,11, 0.5, 18)];
        lineView2.backgroundColor = UIColorFromRGBValue(0xdddddd);
        [_scrollView addSubview:lineView2];
        
        //
        //  bottom lineView
        //
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0, width4btn, 2.0f)];
        _bottomLineView.backgroundColor = [UIColor blueColor];
//        [_scrollView addSubview:_bottomLineView];
        
        [self addSubview:_scrollView];
    }
    return self;
}

//
//  btn clicked
//
- (void)segmentedControlChange:(UIButton *)btn
{
    btn.selected = YES;
//    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    for (UIButton *subBtn in self.array4Btn) {
        if (subBtn != btn) {
            subBtn.selected = NO;
            subBtn.backgroundColor = [UIColor clearColor];
        }
    }
    
    CGRect rect4boottomLine = self.bottomLineView.frame;
    rect4boottomLine.origin.x = btn.frame.origin.x;
    
    CGPoint pt = CGPointZero;
    BOOL canScrolle = NO;
    if ((btn.tag - Define_Tag_add) >= 2 && [_array4Btn count] > 4 && [_array4Btn count] > (btn.tag - Define_Tag_add + 2)) {
        pt.x = btn.frame.origin.x - Min_Width_4_Button*1.5f;
        canScrolle = YES;
    }else if ([_array4Btn count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_array4Btn count]){
        pt.x = (_array4Btn.count - 4) * Min_Width_4_Button;
        canScrolle = YES;
    }else if (_array4Btn.count > 4 && (btn.tag - Define_Tag_add) < 2){
        pt.x = 0;
        canScrolle = YES;
    }
    
    if (canScrolle) {
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = pt;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.bottomLineView.frame = rect4boottomLine;
            }];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomLineView.frame = rect4boottomLine;
        }];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hySegmentedControlSelectAtIndex:)]) {
        [self.delegate hySegmentedControlSelectAtIndex:btn.tag - 1000];
    }
}


#warning ////// index 从 0 开始
// delegete method
- (void)changeSegmentedControlWithIndex:(NSInteger)index
{
    if (index > [_array4Btn count]-1) {
        NSLog(@"index 超出范围");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"index 超出范围" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
        return;
    }
    
    UIButton *btn = [_array4Btn objectAtIndex:index];
    [self segmentedControlChange:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
