//
//  ViewController.m
//  QWER
//
//  Created by Barninets on 11/28/14.
//  Copyright (c) 2014 Barninets. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)evaluatingExpression:(id)sender
{
    
    NSString *line = self.label.text;
    NSError *error = nil;
    
    
    DDMathOperatorSet *defaultOperators = [DDMathOperatorSet defaultOperatorSet];
    defaultOperators.interpretsPercentSignAsModulo = NO;
    
    DDMathOperator *powerOperator = [defaultOperators operatorForFunction:DDOperatorPower];
    powerOperator.associativity = DDOperatorAssociativityRight;
    
    DDMathEvaluator *evaluator = [[DDMathEvaluator alloc] init];
    
    [evaluator setFunctionResolver:^DDMathFunction (NSString *name) {
        printf("\tResolving unknown function: %s\n", [name UTF8String]);
        return ^(NSArray *args, NSDictionary *substitutions, DDMathEvaluator *eval, NSError **error) {
            return [DDExpression numberExpressionWithNumber:@42];
        };
    }];
    
    [evaluator setVariableResolver:^(NSString *variable) {
        printf("\tResolving unknown variable: %s\n", [variable UTF8String]);
        return @1;
    }];
    

    DDMathStringTokenizer *tokenizer = [[DDMathStringTokenizer alloc] initWithString:line operatorSet:nil error:&error];
    DDParser *parser = [DDParser parserWithTokenizer:tokenizer error:&error];
    
    DDExpression *expression = [parser parsedExpressionWithError:&error];
    DDExpression *rewritten = [[DDExpressionRewriter defaultRewriter] expressionByRewritingExpression:expression withEvaluator:evaluator];
    
    NSNumber *value = [evaluator evaluateExpression:rewritten withSubstitutions:nil error:&error];
    
    self.label.text = [value stringValue];
    
}

@end








