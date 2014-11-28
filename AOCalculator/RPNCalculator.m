//
//  RPNCalculator.m
//  aocalculator
//
//  Created by Alex Ozun on 26.11.14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//

#import "RPNCalculator.h"
#import "Stack.h"

@implementation RPNCalculator

-(NSNumber*)Calculate:(NSMutableString *)input{
    NSMutableString* output = [[NSMutableString alloc] init];
    NSNumber* result;
    
    output = [self ConvertInfixToPrefixNotationForString:input];
    result = [self ProcessInput:output];
    
    return result;
}


-(BOOL)isDelimiter:(unichar)character{
    return character == ' ';
}


-(BOOL)isOperator:(unichar)character{
    BOOL result = NO;
    NSString* str = @"-+*/^()!";
    for (NSInteger i = 0; i  < [str length]; i++) {
        if(character == [str characterAtIndex:i]){
            result = YES;
            break;
        }
    }
    return result;
}

-(BOOL)isUnaryMinusForInput:(NSString*)input atIndex:(NSInteger)index{
    BOOL result = NO;
    
    if( (([input characterAtIndex:index] == '-') && !index) || (([input characterAtIndex:index] == '-') && ([self isOperator:[input characterAtIndex:index -1]]))){
        result = YES;
    }
    return result;
}

-(BOOL)isDigit:(unichar)character{
    NSString* str = [NSString stringWithCharacters:&character length:1];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [formatter numberFromString:str];
    NSLog(@"%@",number);
    
    return number ? YES : NO;
}


-(NSInteger)GetPriority:(unichar)character{
    switch (character)
    {
        case '(': return 0;
        case ')': return 1;
        case '+': return 2;
        case '-': return 3;
        case '*': return 4;
        case '/': return 4;
        case '!' :return 5;
        case '^': return 6;
        default : return 7;
    }
}


-(NSMutableString*)ConvertInfixToPrefixNotationForString:(NSMutableString*)input{
    NSMutableString* output = [[NSMutableString alloc] init];
    Stack* stack = [[Stack alloc] init];
    
    for (NSInteger i = 0; i < [input length]; i++) {
        if([self isDelimiter:[input characterAtIndex:i]]){
            continue;
        }
        
        if([self isDigit:[input characterAtIndex:i]]){
            while (![self isDelimiter:[input characterAtIndex:i]]
                && ![self isOperator:[input characterAtIndex:i]]) {
                
                unichar c = [input characterAtIndex:i];
                [output appendString:[NSMutableString stringWithCharacters:&c length:1]];
                i++;
                if(i == [input length])break;
            }
            [output appendString:@" "];
            i--;
        }
        
        if([self isOperator:[input characterAtIndex:i]]){
            
            unichar c = [input characterAtIndex:i];
            
            if([self isUnaryMinusForInput:input atIndex:i]){
                c = '!';
            }
            
            if([input characterAtIndex:i] == '('){
                unichar c =[input characterAtIndex:i];
                NSString* str = [NSString stringWithCharacters:&c length:1];
                [stack pushObject:str];
            }
            else if ( [input characterAtIndex:i] == ')' ){
                NSString* str = [stack popObject];
                
                while (![str isEqualToString:@"("]) {
                    [output appendString:str];
                    [output appendString:@" "];
                    str = [stack popObject];
                }
            }
            else{
                if([stack count]){
                    if([self GetPriority:c]
                    <= [self GetPriority:[[stack peekObject] characterAtIndex:0]]){
                        [output appendString:[stack popObject]];
                        [output appendString:@" "];
                    }
                }
               
                NSString* str = [NSString stringWithCharacters:&c length:1];
                [stack pushObject:str];
            }
        }
    }
    
    while ([stack count]) {
        [output appendString:[stack popObject]];
        [output appendString:@" "];
    } 
    
    
    return output;
}



-(NSNumber*)ProcessInput:(NSMutableString*)input{
    double result = 0;
    Stack* stack = [[Stack alloc] init];
    
    for (NSInteger i = 0; i < [input length]; i++) {
        NSMutableString* str = [NSMutableString string];
        
       /* if([input characterAtIndex:i] == '!'){
            [str appendString:@"-"];
            i++;
        }*/
        if([self isDigit:[input characterAtIndex:i]]){
            
            while (![self isDelimiter:[input characterAtIndex:i]]
                && ![self isOperator:[input characterAtIndex:i]]) {
                
                unichar c = [input characterAtIndex:i];
                [str appendString:[NSString stringWithCharacters:&c length:1]];
                i++;
                if(i == [input length])break;
            }
            NSNumber* num = [NSNumber numberWithDouble:[str doubleValue]];
            [stack pushObject:num];
            i--;
        }
        if([self isOperator:[input characterAtIndex:i]]){
            double a = [[stack popObject] doubleValue];
            double b = [[stack popObject] doubleValue];
            
            switch ([input characterAtIndex:i]) {
                case '!': result = -a;
                    [stack pushObject:[NSNumber numberWithDouble:b]];
                    break;
                case '+': result = b + a;
                    break;
                case '-': result = b - a;
                    break;
                case '*': result = b * a;
                    break;
                case '/': result = b / a;
                    break;
                case '^': result = pow(b, a);
                    break;
            }
            NSNumber* num = [NSNumber numberWithDouble:result];
            [stack pushObject:num];
        }

    
    }
    return [stack peekObject];
}
@end
