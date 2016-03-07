//
//  UIView+Corner.m
//  正确圆角设置方式
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 kun. All rights reserved.
//

#import "UIView+Corner.h"

//@interface UIView ()
//
//@property (nonatomic, assign) BOOL drCornered;
//
//@end

@implementation UIView (Corner)

- (void)dr_cornerWithRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    if (radius == -1) {
        radius = MIN(width, height)/2;
    }
    
    [path  appendPath:[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)]];
    /*
     字面意思是“奇偶”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点的数量。如果结果是奇数则认为点在内部，是偶数则认为点在外部
     */
    [path setUsesEvenOddFillRule:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.fillColor = bgColor.CGColor;
    if ([self isKindOfClass:[UILabel class]]) {
        //UILabel 机制不一样的 要不您去查查 😄
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.layer addSublayer:shapeLayer];
        });
        return;
    }
    [self.layer addSublayer:shapeLayer];
}

//- (BOOL)hasDRCornered {
//    return self.drCornered;
//}


@end
