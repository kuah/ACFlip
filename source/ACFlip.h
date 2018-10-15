//
//  ACFlip.h
//  ACFlip
//
//  Created by 陈世翰 on 2018/8/6.
//  Copyright © 2018年 Kuah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ACFlip;
@protocol ACFlipDelegate<NSObject>
@optional
-(void)flipDidFinished:(ACFlip *)flipItem isReversedFlip:(BOOL)isReversedFlip;
@end

@interface ACFlip : NSObject<ACFlipDelegate>
/**flip duration*/
@property (nonatomic,assign)CGFloat duration;
/**是否被翻转*/
@property (nonatomic,assign,readonly)BOOL isReversed;
/**是否在动画中*/
@property (nonatomic,assign,readonly)BOOL isAnimating;
/**是否在动画中*/
@property (nonatomic,assign)BOOL clockwise;
@property (nonatomic, weak, nullable) id <ACFlipDelegate> delegate;
/**
 *  @brief 建立翻转动画关联
 *  @param view 正面的view
 *  @param backwardView 背面的view
 *  @return instance
 */
+(instancetype)flip:(UIView *)view and:(UIView *)backwardView;
/**
 *  @brief 建立翻转动画关联
 *  @param view 正面的view
 *  @param backwardView 背面的view
 *  @param clockwise 顺时针
 *  @return instance
 */
+(instancetype)flip:(UIView *)view and:(UIView *)backwardView clockwise:(BOOL)clockwise;
/**
 *  @brief 执行翻转动画
 */
-(void)flip;
@end
