//
//  ViewController.m
//  AOCalculator
//
//  Created by Alex Ozun on 11/22/14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//


/*
\((?:\d+(?:[\+\*\-\/]\d+)*[\+\*\-\/]\d+)+\)
 Любые бинарные операции внутри скобок
 
^[\+\*\/\^]|[\+\-\*\/\^][\+\-\*\/\^]+
 
Две операции подряд или одна операция в начале строки за исключением унарного минуса
 
\d+\.\.+|\d+\.[\+\-\*\/\^]+|\d+\.$
 Две точки или точка и операция или точка в конце выражения
 
 [\+\-\*\/\^]$
 Операция в конце выражения
 */



#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.inputDisplay.text  = @"";
    self.outputDisplay.text = @"";
    _calculator = [[RPNCalculator alloc] init];
    
    
    NSString* str = @"2++";
    NSMutableString* replacementString = [NSMutableString stringWithString:str];
    [replacementString deleteCharactersInRange:NSMakeRange([replacementString length]-2, 1)];
    
    NSString* pattern = @"^[+*/^]|[+-*/^][+-*/^]+";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    //NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^[+*/^]|[+-*/^][+-*/^]+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange textRange = NSMakeRange(0, str.length);
    
    NSString* str2 = [regex stringByReplacingMatchesInString:str options:0 range:textRange withTemplate:replacementString];
    NSLog(@"%@",str2);
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)inputCallback:(id)sender {
    NSInteger tag = [sender tag];
    NSMutableString* buffer = [NSMutableString stringWithString:_inputDisplay.text];
    NSMutableString* ms = [NSMutableString stringWithString:[self.inputDisplay.text mutableCopy]];
    NSNumber* num = [[NSNumber alloc] init];
    switch (tag) {
        case 0:
            [buffer appendString: @"0" ];
            break;
        case 1:
           [buffer appendString: @"1" ];
            break;
        case 2:
            [buffer appendString: @"2" ];
            break;
        case 3:
            [buffer appendString: @"3" ];
            break;
        case 4:
           [buffer appendString: @"4" ];
            break;
        case 5:
            [buffer appendString: @"5" ];
            break;
        case 6:
            [buffer appendString: @"6" ];
            break;
        case 7:
           [buffer appendString: @"7" ];
            break;
        case 8:
            [buffer appendString: @"8" ];
            break;
        case 9:
            [buffer appendString: @"9" ];
            break;
        case 10:
            [buffer appendString: @"+" ];
            break;
        case 11:
            [buffer appendString: @"-" ];
            break;
        case 12:
            [buffer appendString: @"/" ];
            break;
        case 13:
            [buffer appendString: @"*" ];
            break;
        case 14:
            NSLog(@"%ld", (long)tag);
            NSRange range;
            range.location = [buffer length]-1;
            range.length = 1;
            [buffer deleteCharactersInRange:range];
            NSLog(@"%@", buffer);
            break;
        case 15:
            NSLog(@"%ld", (long)tag);
            num = [_calculator Calculate:ms];
            self.outputDisplay.text = [NSString stringWithFormat:@"%@",  num];
            _inputDisplay.text = @"";
            return;
        case 16:
             [buffer appendString: @"(" ];
            break;
        case 17:
            [buffer appendString: @")" ];
            break;
        case 18:
            [buffer appendString: @"^" ];
            break;
        case 19:
            [buffer appendString: @"." ];
            break;
        case 20:
            self.inputDisplay.text = @"";
            self.outputDisplay.text = @"";
            return;
        default:
            break;
    }
    self.inputDisplay.text = buffer;
    
    
}

@end
