//
//  ViewController.m
//  AOCalculator
//
//  Created by Alex Ozun on 11/22/14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//

#import "ViewController.h"
#import "InputValidator.h"


#define FONT_SIZE 45

@interface ViewController ()
@property (strong, nonatomic)   InputValidator* inputValidator;
@property (strong, nonatomic)   RPNCalculator* calculator;
@property                       BOOL isShowingLandscapeView;
@property BOOL isCalculated;
@end


@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.inputDisplay.text  = @"";
    self.outputDisplay.text = @"";
    self.calculator = [[RPNCalculator alloc] init];
    self.inputValidator = [[InputValidator alloc]init];
    self.isCalculated = NO;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)inputCallback:(id)sender {
    NSInteger tag = [sender tag];
    if(self.isCalculated){
        self.inputDisplay.text = @"";
        self.isCalculated = NO;
    }
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:_inputDisplay.text];
    NSNumber* num = [[NSNumber alloc] init];
    BOOL isStringValid = YES;
   
        
    switch (tag) {
        case 0:
            [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"0" ]];
            break;
        case 1:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"1" ]];
            break;
        case 2:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"2" ]];
            break;
        case 3:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"3" ]];
            break;
        case 4:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"4" ]];
            break;
        case 5:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"5" ]];
            break;
        case 6:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"6" ]];
            break;
        case 7:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"7" ]];
            break;
        case 8:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"8" ]];
            break;
        case 9:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"9" ]];
            break;
        case 10:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"+" ]];
            break;
        case 11:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"-" ]];
            break;
        case 12:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"/" ]];
            break;
        case 13:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"*" ]];
            break;
        case 14:
            NSLog(@"%ld", (long)tag);
            NSRange range;
            range.location = [attributedString length]-1;
            range.length = 1;
            if([attributedString length]) [attributedString deleteCharactersInRange:range];

            break;
        case 15:
            NSLog(@"%ld", (long)tag);
            attributedString = [self.inputValidator ValidateAttributedString:attributedString result:&isStringValid];
            if(isStringValid&&![attributedString.string isEqualToString:@""]){
                num = [_calculator Calculate:[attributedString.string mutableCopy]];
                NSString* resultString =[NSString stringWithFormat:@"=%@",num];
                [attributedString appendAttributedString:[[NSAttributedString alloc]
                                          initWithString: resultString]];
                [attributedString addAttribute:NSForegroundColorAttributeName
                                         value:[UIColor blueColor]
                                         range:NSMakeRange([attributedString length] - [resultString length]+1,[resultString length] -1 )];
                self.isCalculated = YES;
            }
            break;
        case 16:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"(" ]];
            break;
        case 17:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@")" ]];
            break;
        case 18:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"^" ]];
            break;
        case 19:
             [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"." ]];
            break;
        case 20:
            self.inputDisplay.text = @"";
            return;
        default:
            break;
    }
      
    attributedString = [self.inputValidator ValidateAttributedString:attributedString result:&isStringValid];
    
    self.inputDisplay.attributedText = attributedString;
    self.inputDisplay.textAlignment = NSTextAlignmentLeft;
    self.inputDisplay.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:FONT_SIZE];
}


-(BOOL)shouldAutorotate{
    return NO;
}

@end
