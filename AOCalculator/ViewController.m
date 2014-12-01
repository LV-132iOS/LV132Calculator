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
 
^[\\+\\*\\/\\^]|[\\+\\-\\*\\/\\^][\\+\\-\\*\\/\\^]+

 
Две операции подряд или одна операция в начале строки за исключением унарного минуса
 
\d+\\.\\.+|\d+\\.[\\+\\-\\*\\/\\^]+|\d+\\.$|\d+\\.\d+\\.+
 Две точки или точка и операция или точка в конце выражения или точка число точка
 
 ^\.
 Точка в начале
 
 [\\+\\-\\*\\/\\^]$

 Операция в конце выражения
 */



#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.inputDisplay.text  = @"";
    self.outputDisplay.text = @"";
    _calculator = [[RPNCalculator alloc] init];
<<<<<<< HEAD
    
    
    NSMutableString* str = @"2++";
    NSMutableString* replacementString = [NSMutableString stringWithString:str];
    [replacementString deleteCharactersInRange:NSMakeRange([replacementString length]-2, 1)];
    
    NSString* pattern = @"^[\\+\\*\\/\\^]|[\\+\\-\\*\\/\\^][\\+\\-\\*\\/\\^]+";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];

    NSRange textRange = NSMakeRange(0, str.length);
    
 
    
    [regex replaceMatchesInString:str
                          options:NSMatchingReportCompletion
                            range:textRange
                     withTemplate:[NSString stringWithCharacters:(const unichar*)[str characterAtIndex:[str length]-2] length:1 ]];
    
  
    NSLog(@"%@",str);
    
=======
>>>>>>> db3c11486def7adcda0aa8a1beb0d03c86adacce
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)inputCallback:(id)sender {
    NSInteger tag = [sender tag];
    NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:_inputDisplay.text];
    NSNumber* num = [[NSNumber alloc] init];
    
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
<<<<<<< HEAD
            if([buffer length]){
                [buffer deleteCharactersInRange:range];
            }
            NSLog(@"%@", buffer);
=======
            if([attributedString length]) [attributedString deleteCharactersInRange:range];
>>>>>>> db3c11486def7adcda0aa8a1beb0d03c86adacce
            break;
        case 15:
            NSLog(@"%ld", (long)tag);
            if([self ValidateString:attributedString]){
                num = [_calculator Calculate:[attributedString.string mutableCopy]];
                self.outputDisplay.text = [NSString stringWithFormat:@"%@",  num];
                _inputDisplay.text = @"";
            }        
            return;
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
            self.outputDisplay.text = @"";
            return;
        default:
            break;
    }
    
    
    
    attributedString = [self ValidateString:attributedString];
 
    self.inputDisplay.attributedText = attributedString;
}

-(NSMutableAttributedString*)ValidateString: (NSMutableAttributedString*)attributedString{
    BOOL result = NO;
    
    NSString* patternForOperators = @"[\\+\\-\\*\\/\\^][\\+\\-\\*\\/\\^\\.]+|\\d+[\\(]|[\\)]\\d|^00+|[\\+\\-\\*\\/\\^]00+";
    NSString* patternForOperatorAtStart = @"^[\\+\\*\\/\\^]|\\([\\+\\*\\/\\^]";
    NSString* patternForOperatorAtTheEnd = @"[\\+\\-\\*\\/\\^]$";
    NSString* patternForDots = @"\\d+\\.\\.+|\\d+\\.[\\+\\-\\*\\/\\^\\)\\(]+|\\d+\\.\\d+\\.+|[\\+\\-\\*\\/\\^\\)\\(]\\.";
    NSString* patternForDotAtStart = @"^\\.";
    NSString* patternForDotAtEnd = @"\\d+\\.$";
    NSString* patternForParenthesis = @"\\(\\d+\\)|[\\+\\-\\*\\/\\^]\\)|\\(\\)|\\)\\(";
    
    NSError* error = nil;
    
    NSRegularExpression* validateOperators = [NSRegularExpression regularExpressionWithPattern:patternForOperators options:0 error:&error];
    NSRegularExpression* validateDots      = [NSRegularExpression regularExpressionWithPattern:patternForDots options:0 error:&error];
    NSRegularExpression* validateParenthesis    = [NSRegularExpression regularExpressionWithPattern:patternForParenthesis options:0 error:&error];
    
    NSRegularExpression* replaceDotAtStart = [NSRegularExpression regularExpressionWithPattern:patternForDotAtStart options:0 error:&error];
    NSRegularExpression* replaceOperatorAtStart = [NSRegularExpression regularExpressionWithPattern:patternForOperatorAtStart options:0 error:&error];
    
    NSRegularExpression* highlightDotAtTheEnd = [NSRegularExpression regularExpressionWithPattern:patternForDotAtEnd options:0 error:&error];
    NSRegularExpression* highlightOperatorAtTheEnd = [NSRegularExpression regularExpressionWithPattern:patternForOperatorAtTheEnd options:0 error:&error];
    

    
    //========CHECK OTHER INPUT=======
    if([validateOperators numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"validateOperators!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
        
        result = YES;
    }
    
    if([validateDots numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"validateDots!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
        
        result = YES;
    }
    
    if([validateParenthesis numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"validateDots!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
        
        result = YES;
    }
    if([highlightDotAtTheEnd numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0,[attributedString length])]){
        NSLog(@"highlightDotAtTheEnd!");
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([attributedString length]-1, 1)];
        
        result = YES;
    }
    
    if([replaceDotAtStart numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"replaceDotAtStart!");
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"0"] atIndex:0];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([attributedString length]-1, 1)];
    
        result = YES;
    }
    
    if([replaceOperatorAtStart numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"replaceOperatorAtStart!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
        result = YES;
    }
    
    if([highlightOperatorAtTheEnd numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"highlightOperatorAtTheEnd!");
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([attributedString length]-1, 1)];
        result = YES;
    }
    
    //=========CHECK FOR PARENTHESIS BALANCE=======
    NSInteger openParenthesisCounter = 0;
    NSInteger closedParenthesisCounter = 0;
    NSInteger lastOpenedParenthesisIndex = 0;
    
    for(NSInteger i = 0; i < [attributedString length]; i++){
        if([attributedString.string characterAtIndex:i] == '('){
            openParenthesisCounter++;
            lastOpenedParenthesisIndex = i;
        }
        if([attributedString.string characterAtIndex:i] == ')') closedParenthesisCounter++;
    }
    if(openParenthesisCounter>closedParenthesisCounter){
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(lastOpenedParenthesisIndex, 1)];
    }
    else if(openParenthesisCounter<closedParenthesisCounter){
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
    }
    
    return  attributedString;
}

@end
