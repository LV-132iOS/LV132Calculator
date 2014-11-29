//
//  T2ViewController.h
//  Test2
//
//  Created by Andrii V. on 26.11.14.
//  Copyright (c) 2014 Andrii V. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface T2ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textf;
@property (strong, nonatomic) IBOutlet UILabel *lab;


@property (nonatomic) BOOL DivadeZero;


- (IBAction)calculate:(id)sender;

@end
