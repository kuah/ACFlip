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
    ACFlip * f = [self new];
    f.forwardView = view;
    f.backwardView = backwardView;
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34  = 1.0/-2000;
    f.forwardView.layer.transform = t1;
    f.backwardView.layer.transform = t1;
    f.backwardView.hidden = YES;
    f.duration = 0.6;
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
        [self animate_flip2];
    }else if([anim isEqual:[self.backwardView.layer animationForKey:@"flipback_1"]]){
        self.forwardView.hidden = NO;
        self.backwardView.hidden = YES;
        [self animate_filpback2];
    }else{
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(flipDidFinished:isReversedFlip:)]) {
            [self.delegate flipDidFinished:self isReversedFlip:[anim isEqual:[self.forwardView.layer animationForKey:@"flip_2"]]];
        }
        _isAnimating = NO;
    }
}
-(void)animationDidStart:(CAAnimation *)anim{
//    NSLog(@"start -  -  - > %@",anim);
}
-(void)animate_flip1{
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnim.beginTime = CACurrentMediaTime();
    rotationAnim.delegate = self;
    rotationAnim.toValue = [NSNumber numberWithFloat: M_PI_2];
    rotationAnim.duration = self.duration*0.5;
    rotationAnim.removedOnCompletion = NO;
    [self.forwardView.layer addAnimation:rotationAnim forKey:@"flip_1"];
}
-(void)animate_flip2{
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnim.delegate = self;
    rotationAnim.beginTime = CACurrentMediaTime();
    rotationAnim.fromValue = [NSNumber numberWithFloat: 1.5*M_PI];
    rotationAnim.toValue = [NSNumber numberWithFloat: 2*M_PI];
    rotationAnim.duration = self.duration*0.5;
    rotationAnim.removedOnCompletion = NO;
    [self.backwardView.layer addAnimation:rotationAnim forKey:@"flip_2"];
}
-(void)animate_filpback1{
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnim.delegate = self;
    rotationAnim.beginTime = CACurrentMediaTime();
    rotationAnim.fromValue = [NSNumber numberWithFloat: 0];
    rotationAnim.toValue = [NSNumber numberWithFloat: -M_PI_2];
    rotationAnim.duration = self.duration*0.5;
    rotationAnim.removedOnCompletion = NO;
    [self.backwardView.layer addAnimation:rotationAnim forKey:@"flipback_1"];
}
-(void)animate_filpback2{
    CABasicAnimation* rotationAnim;
    rotationAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnim.beginTime = CACurrentMediaTime();
    rotationAnim.delegate = self;
    rotationAnim.fromValue = [NSNumber numberWithFloat: M_PI_2];
    rotationAnim.toValue = [NSNumber numberWithFloat: 0];
    rotationAnim.duration = self.duration*0.5;
    rotationAnim.removedOnCompletion = NO;
    [self.forwardView.layer addAnimation:rotationAnim forKey:@"flipback_2"];
}

@end
