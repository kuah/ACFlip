# ACFlip
> 简单实用的翻转效果

[![Version](https://img.shields.io/cocoapods/v/ACFlip.svg?style=flat)](http://cocoadocs.org/docsets/ACFlip)
[![Platform](https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat)](http://cocoadocs.org/docsets/ACFlip)

![QQ20181015-183200](https://ws2.sinaimg.cn/large/006tNbRwgy1fw937mhw0jg305w0bnhdu.gif)

## Install

### Cocoapod

```objective-c
pod 'ACFlip'
```

## Usage

```objective-c
#import "ACFlip.h"

self.flipAnim = [ACFlip flip:<#view#> and:<#view#>];//对两个view生成出关联实体ACFlip

[self.flipAnim flip];//执行翻转
```

## Api

```objective-c
/**flip duration*/
@property (nonatomic,assign)CGFloat duration;
/**是否被翻转*/
@property (nonatomic,assign,readonly)BOOL isReversed;
/**是否在动画中*/
@property (nonatomic,assign,readonly)BOOL isAnimating;
/**代理*/
@property (nonatomic, weak, nullable) id <ACFlipDelegate> delegate;
```



```objective-c
@protocol ACFlipDelegate<NSObject>
@optional
 /**
 *  @brief 执行翻转动画
 *  @param flipItem 翻转关联实体
 *  @param isReversedFlip 是否从正面翻转到背面
 */
-(void)flipDidFinished:(ACFlip *)flipItem isReversedFlip:(BOOL)isReversedFlip;
@end
```

