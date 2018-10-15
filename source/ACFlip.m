//
//  ACFlip.m
//  ACFlip
//
//  Created by 陈世翰 on 2018/8/6.
//  Copyright © 2018年 Kuah. All rights reserved.
//

#import "ACFlip.h"
@interface ACFlip()<CAAnimationDelegate>{
    BOOL _isReversed;
    BOOL _isAnimating;
}
/**前面的view*/
@property (nonatomic,strong)UIView *forwardView;
/**后面的view*/
@property (nonatomic,strong)UIView *backwardView;
@end

@implementation ACFlip
+(instancetype)flip:(UIView *)view and:(UIView *)backwardView{
   return [self flip:view and:backwardView clockwise:NO];
}
/**
 *  @brief 建立翻转动画关联
 *  @param view 正面的view
 *  @param backwardView 背面的view
 *  @param clockwise 顺时针
 *  @return instance
 */
+(instancetype)flip:(UIView *)view and:(UIView *)backwardView clockwise:(BOOL)clockwise{
    ACFlip * f = [self new];
    f.forwardView = view;
    f.backwardView = backwardView;
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34  = 1.0/-2000;
    f.forwardView.layer.transform = t1;
    f.backwardView.layer.transform = t1;
    f.backwardView.hidden = YES;
    f.duration = 0.6;
    f.clockwise = clockwise;
    return f;
}
-(BOOL)isReversed{
    return _isReversed;
}
-(BOOL)isAnimating{
    return _isAnimating;
}
-(void)flip{
    if (_isAnimating) return;
    _isAnimating = YES;
    if (!_isReversed) {
        [self animate_flip1];
    }else{
        [self animate_filpback1];
    }
    _isReversed = !_isReversed;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isEqual:[self.forwardView.layer animationForKey:@"flip_1"]]) {
        self.forwardView.hidden = YES;
        self.backwardView.hidden = NO;
        [self.forwardView.layer removeAllAnimations];
        [self.backwardView.layer removeAllAnimations];
        [self animate_flip2];
    }else if([anim isEqual:[self.backwardView.layer animationForKey:@"flipback_1"]]){
        self.forwardView.hidden = NO;
        self.backwardView.hidden = YES;
        [self.forwardView.layer removeAllAnimations];
        [self.backwardView.layer removeAllAnimations];
        [self animate_filpback2];
    }else{
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(flipDidFinished:isReversedFlip:)]) {
            [self.delegate flipDidFinished:self isReversedFlip:[anim isEqual:[self.forwardView.layer animationForKey:@"flip_2"]]];
        }
        [self.forwardView.layer removeAllAnimations];
        [self.backwardView.layer removeAllAnimations];
        _isAnimating = NO;
    }
}
-(void)animationDidStart:(CAAnimation *)anim{
}
-(void)animate_flip1{
    //rotate
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    CGFloat radian = self.clockwise?-M_PI_2:M_PI_2;
    rotationAnim.toValue = [NSNumber numberWithFloat: radian];
    
    //coming large
    CABasicAnimation* forward_scaleAnim;
    forward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forward_scaleAnim.fromValue = @1;
    forward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.2];
    
    CABasicAnimation* backward_scaleAnim;
    backward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backward_scaleAnim.fromValue = @1;
    backward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.2];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.duration*0.5;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.delegate = self;
    group.repeatCount = 1;
    
    group.animations = [NSArray arrayWithObjects:rotationAnim,forward_scaleAnim,nil];
    [self.forwardView.layer addAnimation:group forKey:@"flip_1"];
    //coming large behind
    [self.backwardView.layer addAnimation:backward_scaleAnim forKey:@"b_scale"];
}
-(void)animate_flip2{
    //rotate
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    CGFloat from_radian = self.clockwise?M_PI_2:1.5*M_PI;
    CGFloat to_radian = self.clockwise?0:2*M_PI;
    rotationAnim.fromValue = [NSNumber numberWithFloat: from_radian];
    rotationAnim.toValue = [NSNumber numberWithFloat: to_radian];
    
    //coming small
    CABasicAnimation* forward_scaleAnim;
    forward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forward_scaleAnim.fromValue = @1.2;
    forward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.0];
    
    CABasicAnimation* backward_scaleAnim;
    backward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backward_scaleAnim.fromValue = @1.2;
    backward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.0];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.delegate = self;
    group.duration = self.duration*0.5;
    group.repeatCount = 1;
    
    group.animations = [NSArray arrayWithObjects:rotationAnim, backward_scaleAnim,nil];
    [self.backwardView.layer addAnimation:group forKey:@"flip_2"];
    //coming small behind
    [self.forwardView.layer addAnimation:forward_scaleAnim forKey:@"b_scale"];
}
-(void)animate_filpback1{
    //rotate
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    CGFloat from_radian = self.clockwise?0:0;
    CGFloat to_radian = self.clockwise?M_PI_2:-M_PI_2;
    rotationAnim.fromValue = [NSNumber numberWithFloat: from_radian];
    rotationAnim.toValue = [NSNumber numberWithFloat: to_radian];

    //coming large
    CABasicAnimation* forward_scaleAnim;
    forward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forward_scaleAnim.fromValue = @1;
    forward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.2];
    
    CABasicAnimation* backward_scaleAnim;
    backward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backward_scaleAnim.fromValue = @1;
    backward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.2];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.delegate = self;
    group.duration = self.duration*0.5;
    group.repeatCount = 1;
    
    group.animations = [NSArray arrayWithObjects:rotationAnim, backward_scaleAnim,nil];
    [self.backwardView.layer addAnimation:group forKey:@"flipback_1"];
    //coming large behind
    [self.forwardView.layer addAnimation:forward_scaleAnim forKey:@"b_scale"];
}
-(void)animate_filpback2{
    //rotate
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    CGFloat from_radian = self.clockwise?-M_PI_2:M_PI_2;
    CGFloat to_radian = self.clockwise?0:0;
    rotationAnim.fromValue = [NSNumber numberWithFloat: from_radian];
    rotationAnim.toValue = [NSNumber numberWithFloat: to_radian];
    
    //coming small
    CABasicAnimation* forward_scaleAnim;
    forward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forward_scaleAnim.fromValue = @1.2;
    forward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.0];
    
    CABasicAnimation* backward_scaleAnim;
    backward_scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backward_scaleAnim.fromValue = @1.2;
    backward_scaleAnim.toValue = [NSNumber numberWithFloat: 1.0];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = self.duration*0.5;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.delegate = self;
    group.repeatCount = 1;
    
    group.animations = [NSArray arrayWithObjects:rotationAnim,forward_scaleAnim,nil];
    [self.forwardView.layer addAnimation:group forKey:@"flipback_2"];
    //coming small behind
    [self.backwardView.layer addAnimation:backward_scaleAnim forKey:@"b_scale"];
}

@end
