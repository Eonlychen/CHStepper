//
//  CHStepper.m
//  Stepper
//
//  Created by guxiangyun on 2019/3/28.
//  Copyright © 2019 chenran. All rights reserved.
//

#import "CHStepper.h"

@interface CHStepper ()

/** 减号 */
@property (nonatomic, strong) UILabel *minusLabel;
/** 加号 */
@property (nonatomic, strong) UILabel *plusLabel;
/** 中间数字 */
@property (nonatomic, strong) UILabel *countLabel;


@end

@implementation CHStepper
@synthesize count = _count;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.minusLabel = UILabel.new;
        self.countLabel = UILabel.new;
        self.plusLabel = UILabel.new;
        [self addSubview:self.minusLabel];
        [self addSubview:self.countLabel];
        [self addSubview:self.plusLabel];
        
        self.clipsToBounds = true;

        _minusLabel.frame = CGRectMake(0, 0, frame.size.width/3, frame.size.height);
        _countLabel.frame = CGRectMake(CGRectGetMaxX(_minusLabel.frame), 0, frame.size.width/3, frame.size.height);
        _plusLabel.frame = CGRectMake(CGRectGetMaxX(_countLabel.frame), 0, frame.size.width/3, frame.size.height);

        _minusLabel.userInteractionEnabled = true;
        _minusLabel.text = @"-";
        _minusLabel.enabled = false;
        _minusLabel.textAlignment = NSTextAlignmentCenter;
        _minusLabel.font = [UIFont boldSystemFontOfSize:28];
        [_minusLabel addGestureRecognizer:[UITapGestureRecognizer.alloc initWithTarget:self action:@selector(minus:)]];
        
        _countLabel.text = @"0";
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont boldSystemFontOfSize:20];
        
        _plusLabel.userInteractionEnabled = true;
        _plusLabel.text = @"+";
        _plusLabel.textAlignment = NSTextAlignmentCenter;
        _plusLabel.font = [UIFont boldSystemFontOfSize:28];
        [_plusLabel addGestureRecognizer:[UITapGestureRecognizer.alloc initWithTarget:self action:@selector(plus:)]];
        
        [self defaultSetting];
    }
    return self;
}


- (void)minus:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(stepper:didSelectedStepperStatus:)]) {
        self.plusLabel.enabled = true;
        CGFloat dif = self.count - self.stepValue;
        if (dif < self.minimumValue) {
            self.minusLabel.enabled = false;
        }else{
            self.minusLabel.enabled = dif - self.stepValue >= self.minimumValue;
            [self changeCountLabelWithCount:dif];
            [self.delegate stepper:self didSelectedStepperStatus:StepperStatusMinus];
        }
    }
    /** block ****
     
    if (self.stepperSelectedBlock) {
        self.plusLabel.enabled = true;
        CGFloat dif = self.count - self.stepValue;
        if (dif < self.minimumValue) {
            self.minusLabel.enabled = false;
        }else{
            self.minusLabel.enabled = dif - self.stepValue >= self.minimumValue;
            [self changeCountLabelWithCount:dif];
            self.stepperSelectedBlock(self, StepperStatusMinus);
        }
    }
     */
}
- (void)plus:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(stepper:didSelectedStepperStatus:)]) {
        self.minusLabel.enabled = true;
        CGFloat sum = self.count + self.stepValue;
        if (sum > self.maximumValue) {
            self.plusLabel.enabled = false;
        }else {
            self.plusLabel.enabled = sum + self.stepValue < self.maximumValue;
            [self changeCountLabelWithCount:sum];
            [self.delegate stepper:self didSelectedStepperStatus:StepperStatusPlus];
        }
    }
    /** block ****

     if (self.stepperSelectedBlock) {
        self.minusLabel.enabled = true;
        CGFloat sum = self.count + self.stepValue;
        if (sum > self.maximumValue) {
            self.plusLabel.enabled = false;
        }else {
            self.plusLabel.enabled = sum + self.stepValue < self.maximumValue;
            [self changeCountLabelWithCount:sum];
            self.stepperSelectedBlock(self, StepperStatusPlus);
        }
    }
     */
}

- (void)defaultSetting {
    self.maximumValue = 100;
    self.minimumValue = 0;
    self.stepValue = 1;
    self.countType = StepperCountTypeInteger;
}

- (void)changeCountLabelWithCount:(CGFloat)count {
    switch (self.countType) {
        case StepperCountTypeFloatOne:
            self.countLabel.text = [NSString stringWithFormat:@"%.1f",count];
            break;
//        case StepperCountTypeFloatTwo:
//            self.countLabel.text = [NSString stringWithFormat:@"%.2f",count];
//            break;
        default:
            self.countLabel.text = [NSString stringWithFormat:@"%.0f",count];
            break;
    }
}

#pragma mark -- setter
- (void)setMinimumValue:(CGFloat)minimumValue {
    _minimumValue = minimumValue;
    [self changeCountLabelWithCount:minimumValue];
}
- (void)setCount:(CGFloat)count {
    _count = count;
    [self changeCountLabelWithCount:count];
}
#pragma mark -- getter
- (CGFloat)count {
    return (CGFloat)self.countLabel.text.floatValue;
}


#pragma mark -- public

- (void)setBothSidesBackgroundColor:(UIColor *)color {
    self.minusLabel.backgroundColor = color;
    self.plusLabel.backgroundColor = color;
}
- (void)setStepperLayerCornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = cornerRadius;
}

@end
