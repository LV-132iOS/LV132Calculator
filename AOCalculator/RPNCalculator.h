//
//  RPNCalculator.h
//  aocalculator
//
//  Created by Alex Ozun on 26.11.14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RPNCalculator : NSObject

-(NSNumber*)Calculate:(NSMutableString*)input;
-(NSMutableString*)ConvertInfixToPrefixNotationForString:(NSMutableString*)input;
-(NSNumber*)ProcessInput:(NSMutableString*)input;

-(BOOL)isDelimiter:(unichar)character;
-(BOOL)isOperator:(unichar)character;
-(BOOL)isDigit:(unichar)character;
-(NSInteger)GetPriority:(unichar)character;
@end