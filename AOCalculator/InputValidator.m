//
//  InputValidator.m
//  RPLCalculator
//
//  Created by Admin on 02.12.14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//

#import "InputValidator.h"
@interface InputValidator()
@property NSString* patternForOperators;
@property NSString* patternForOperatorAtStart;
@property NSString* patternForOperatorAtTheEnd;
@property NSString* patternForDots;
@property NSString* patternForDotAtStart;
@property NSString* patternForDotAtEnd;
@property NSString* patternForParenthesis;

@property NSRegularExpression* validateOperators;
@property NSRegularExpression* validateDots;
@property NSRegularExpression* validateParenthesis;
@property NSRegularExpression* replaceDotAtStart;
@property NSRegularExpression* replaceOperatorAtStart;
@property NSRegularExpression* highlightDotAtTheEnd;
@property NSRegularExpression* highlightOperatorAtTheEnd;
@end

@implementation InputValidator

-(instancetype)init{
    self = [super init];
    self.patternForOperators        = @"[\\+\\-\\*\\/\\^][\\+\\-\\*\\/\\^\\.]+|\\d+[\\(]|[\\)]\\d|^00+|[\\+\\-\\*\\/\\^]00+";
    self.patternForOperatorAtStart  = @"^[\\+\\*\\/\\^]|\\([\\+\\*\\/\\^]";
    self.patternForOperatorAtTheEnd = @"[\\+\\-\\*\\/\\^]$";
    self.patternForDots             = @"\\d+\\.\\.+|\\d+\\.[\\+\\-\\*\\/\\^\\)\\(]+|\\d+\\.\\d+\\.+|[\\+\\-\\*\\/\\^\\)\\(]\\.";
    self.patternForDotAtStart       = @"^\\.";
    self.patternForDotAtEnd         = @"\\d+\\.$";
    self.patternForParenthesis      = @"\\(\\d+\\)|[\\+\\-\\*\\/\\^]\\)|\\(\\)|\\)\\(";
    
    NSError* error = nil;
    self.validateOperators         = [NSRegularExpression regularExpressionWithPattern:self.patternForOperators
                                                                               options:0
                                                                                 error:&error];
    self.validateDots              = [NSRegularExpression regularExpressionWithPattern:self.patternForDots
                                                                               options:0
                                                                                 error:&error];
    self.validateParenthesis       = [NSRegularExpression regularExpressionWithPattern:self.patternForParenthesis
                                                                               options:0
                                                                                 error:&error];
    self.replaceDotAtStart         = [NSRegularExpression regularExpressionWithPattern:self.patternForDotAtStart
                                                                               options:0
                                                                                 error:&error];
    self.replaceOperatorAtStart    = [NSRegularExpression regularExpressionWithPattern:self.patternForOperatorAtStart
                                                                               options:0
                                                                                 error:&error];
    self.highlightDotAtTheEnd      = [NSRegularExpression regularExpressionWithPattern:self.patternForDotAtEnd
                                                                               options:0
                                                                                 error:&error];
    self.highlightOperatorAtTheEnd = [NSRegularExpression regularExpressionWithPattern:self.patternForOperatorAtTheEnd
                                                                               options:0
                                                                                 error:&error];
    return  self;
}

-(NSMutableAttributedString*)ValidateAttributedString: (NSMutableAttributedString*)attributedString result:(BOOL*)isValid{

    //========CHECK OTHER INPUT=======
    if([self.validateOperators numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"validateOperators!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];

    }
    
    if([self.validateDots numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"validateDots!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
    }
    
    if([self.validateParenthesis numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"validateDots!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
    }
    if([self.highlightDotAtTheEnd numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0,[attributedString length])]){
        NSLog(@"highlightDotAtTheEnd!");
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([attributedString length]-1, 1)];
          *isValid = NO;
    }
    
    if([self.replaceDotAtStart numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"replaceDotAtStart!");
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"0"] atIndex:0];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([attributedString length]-1, 1)];
    }
    
    if([self.replaceOperatorAtStart numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"replaceOperatorAtStart!");
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
    }
    
    if([self.highlightOperatorAtTheEnd numberOfMatchesInString:attributedString.string options:0 range:NSMakeRange(0, [attributedString length])]){
        NSLog(@"highlightOperatorAtTheEnd!");
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([attributedString length]-1, 1)];
        *isValid = NO;
    }
    
    //=========CHECK FOR PARENTHESIS BALANCE=======
    NSInteger openParenthesisCounter     = 0;
    NSInteger closedParenthesisCounter   = 0;
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
          *isValid = NO;
    }
    else if(openParenthesisCounter<closedParenthesisCounter){
        [attributedString deleteCharactersInRange:NSMakeRange([attributedString length]-1, 1)];
    }
    
    return  attributedString;
}

@end
