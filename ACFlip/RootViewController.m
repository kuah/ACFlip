//
//  RootViewController.m
//  ACFlip
//
//  Created by 陈世翰 on 2018/8/3.
//  Copyright © 2018年 Kuah. All rights reserved.
//

#import "RootViewController.h"
#import "ACFlip.h"
CGFloat const flip_duration = 0.6;

@interface RootViewController ()<CAAnimationDelegate>{
    BOOL _isReversed;
    BOOL _isAnimating;
}
/**<#decr#>*/
@property (nonatomic,strong)UIButton *button0;
/**<#decr#>*/
@property (nonatomic,strong)UIImageView *view1;
/**<#decr#>*/
@property (nonatomic,strong)UIImageView *view2;
/**<#decr#>*/
@property (nonatomic,strong)ACFlip *flipAnim;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpDemo];
    
    self.view1.center = self.view.center;
    self.view2.center = self.view.center;
    
    self.flipAnim = [ACFlip flip:self.view1 and:self.view2];
}
-(void)click:(id)sender{
    [self.flipAnim flip];
}








-(void)setUpDemo{
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIButton * button0 = [[UIButton alloc]initWithFrame:(CGRect){0,0,50,50}];
    button0.backgroundColor = [UIColor blueColor];
    [self.view addSubview: button0];
    [button0 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.button0 = button0;
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view1];
}
-(UIImageView *)view1{
    if (!_view1) {
        _view1 = [UIImageView new];
        _view1.frame =(CGRect){0,0,200,300};
        _view1.backgroundColor = [UIColor purpleColor];
        _view1.image =[UIImage imageNamed:@"1"];
        _view1.layer.masksToBounds = YES;
    }
    return _view1;
}
-(UIImageView *)view2{
    if (!_view2) {
        _view2 = [UIImageView new];
        _view2.frame =(CGRect){0,0,200,300};
        _view2.backgroundColor = [UIColor greenColor];
        _view2.image =[UIImage imageNamed:@"2"];
        _view2.layer.masksToBounds = YES;
    }
    return _view2;
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
