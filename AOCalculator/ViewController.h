//
//  ViewController.h
//  AOCalculator
//
//  Created by Alex Ozun on 11/22/14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutputDisplay.h"
#import "InputDisplay.h"
#import "RPNCalculator.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet OutputDisplay *outputDisplay;
@property (weak, nonatomic) IBOutlet InputDisplay *inputDisplay;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *inputButton;
@property (strong, nonatomic) RPNCalculator* calculator;

@end