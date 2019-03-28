//
//  ViewController.m
//  Stepper
//
//  Created by guxiangyun on 2019/3/28.
//  Copyright © 2019 chenran. All rights reserved.
//

#import "ViewController.h"
#import "CHStepper/CHStepper.h"

@interface ViewController ()<CHStepperDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CHStepper *stepper = [CHStepper.alloc  initWithFrame:CGRectMake(50, 200, 200, 40)];
//    [stepper setBothSidesBackgroundColor:UIColor.cyanColor];
    [stepper setStepperLayerCornerRadius:3];
    stepper.delegate = self;
    stepper.countType = StepperCountTypeInteger;
    stepper.maximumValue = 20;
    stepper.minimumValue = 1;
    stepper.stepValue = 2;
//    [stepper setStepperSelectedBlock:^(CHStepper * _Nonnull stepper, StepperStatus status) {
//       NSLog(@"----%f,---%f,----%f,-----%f",stepper.count,stepper.maximumValue,stepper.minimumValue,stepper.stepValue);
//        if (StepperStatusMinus == status) {
//            NSLog(@"block minus");
//        }else {
//            NSLog(@"block plus");
//        }
//    }];
    [self.view addSubview:stepper];
    
}

- (void)stepper:(CHStepper *)stepper didSelectedStepperStatus:(StepperStatus)status {
    
//    NSLog(@"----%f,---%f,----%f,-----%f",stepper.count,stepper.maximumValue,stepper.minimumValue,stepper.stepValue);
//
//    if (StepperStatusMinus == status) {
//        NSLog(@"delegate minus");
//    }else {
//        NSLog(@"delegate plus");
//    }
}

@end
