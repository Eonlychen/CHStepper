//
//  CHStepper.h
//  Stepper
//
//  Created by guxiangyun on 2019/3/28.
//  Copyright © 2019 chenran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 两边 加 减 */
typedef NS_ENUM(NSInteger, StepperStatus) {
    StepperStatusMinus,
    StepperStatusPlus,
};
/** 中间数字显示 （整数，一位小数，两位小数） */
typedef NS_ENUM(NSInteger, StepperCountType) {
    StepperCountTypeInteger,        //整数
    StepperCountTypeFloatOne,       //一位小数
    //StepperCountTypeFloatTwo,       //两位小数
};

@class CHStepper;
@protocol CHStepperDelegate <NSObject>
@optional
- (void)stepper:(CHStepper *)stepper didSelectedStepperStatus:(StepperStatus)status;
@end

typedef void (^StepperSelectedBlock) (CHStepper *stepper, StepperStatus status);

@interface CHStepper : UIView

/**
    delegate block 必须二选一
*/
/** 代理 */
@property (nonatomic, weak) id <CHStepperDelegate>  delegate;
/** block */
@property (nonatomic, copy) StepperSelectedBlock stepperSelectedBlock;



/**
 显示类型，要与stepValue对应
 StepperCountTypeInteger  ---> 1
 StepperCountTypeFloatOne ---> 1.0
 ///StepperCountTypeFloatTwo ---> 1.00
 */
@property (nonatomic) StepperCountType countType;

/** 中间数字 */
@property (nonatomic) CGFloat count;                       // default 0.
@property (nonatomic) CGFloat minimumValue;                 // default 0.
@property (nonatomic) CGFloat maximumValue;                 // default 100.
@property (nonatomic) CGFloat stepValue;                    // default 1.


- (void)setBothSidesBackgroundColor:(UIColor *)color;
- (void)setStepperLayerCornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
