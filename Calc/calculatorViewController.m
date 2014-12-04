//
//  calculatorViewController.m
//  Calc
//
//  Created by Paul on 11/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "calculatorViewController.h"

@interface calculatorViewController ()
@property(strong,nonatomic) NSRegularExpression* regexsign;
@property(strong,nonatomic) NSRegularExpression* regexpoint;
@property(strong,nonatomic) NSRegularExpression* regexbracketopen;
@property(strong,nonatomic) NSRegularExpression* regexbracketclosed;
@property (nonatomic, assign) NSInteger BracketsOpened;
@property (nonatomic, assign) NSInteger BracketsClosed;


@end
@implementation calculatorViewController



- (IBAction)dightpush:(id)sender {
    if(([self.Textonscreen.text characterAtIndex:0] == '0') && ([self.Textonscreen.text length] == 1))
       self.Textonscreen.text = @"";
    if([self.Textonscreen.text characterAtIndex:[self.Textonscreen.text length]-1] == ')')
        return;
        NSString* CurrentNumberAsString=[NSString stringWithFormat:@"%i",[sender tag]];
    NSString* CurentValue=self.Textonscreen.text;
    CurentValue=[CurentValue stringByAppendingString:CurrentNumberAsString];
    self.Textonscreen.text=CurentValue;
    
}

- (IBAction)clrscr:(id)sender {
    self.Textonscreen.text = @"0";
    self.BracketsClosed = 0;
    self.BracketsOpened = 0;
}

- (IBAction)Backspace:(id)sender {
    if([self.Textonscreen.text characterAtIndex:[self.Textonscreen.text length]-1] == '(')
        self.BracketsOpened--;
    if([self.Textonscreen.text characterAtIndex:[self.Textonscreen.text length]-1] == ')')
        self.BracketsClosed--;
    self.Textonscreen.text = [self.Textonscreen.text substringToIndex:[self.Textonscreen.text length]-1];
    if([self.Textonscreen.text isEqual: @""])
        self.Textonscreen.text = @"0";
 

}


- (IBAction)sighnpush:(id)sender {
    if(([self.Textonscreen.text characterAtIndex:0] == '0') && ([self.Textonscreen.text length] == 1))
        if([sender tag] == 1002)
            self.Textonscreen.text = self.Textonscreen.text = @"-";
else
       return;
    
   NSUInteger invalid =[self.regexsign numberOfMatchesInString:self.Textonscreen.text options:0 range:NSMakeRange(0,[self.Textonscreen.text length])];
    BOOL isInvalid = invalid;
    if (isInvalid)
    {
        return;}
    
else
{if([sender tag] == 1001)
    self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@"+"];
 if([sender tag] == 1002)
        self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@"-"];
    if([sender tag] == 1003)
        self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@"*"];
    if([sender tag] == 1004)
        self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@"/"];
    if([sender tag] == 1005)
        self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@"^"];

}

}

- (IBAction)pointpush:(id)sender {
   
    NSUInteger invalid =[self.regexpoint numberOfMatchesInString:self.Textonscreen.text options:0 range:NSMakeRange(0,[self.Textonscreen.text length])];
    BOOL isInvalid = invalid;
    if (isInvalid )
    {
        return;}
     self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@"."];
}


- (void)viewDidLoad
{
    self.regexsign=[[NSRegularExpression alloc]initWithPattern:@"[\\.\\+\\-\\*\\/\\^]$" options:0 error:nil];
    self.regexpoint=[[NSRegularExpression alloc]initWithPattern:@"\\.[0-9]*[0-9]$|[\\.\\+\\-\\*\\/\\^\\(\\)]$" options:0 error:nil];
     self.regexbracketopen=[[NSRegularExpression alloc]initWithPattern:@"[0-9]$|\\)$|\\.$" options:0 error:nil];
    self.regexbracketclosed=[[NSRegularExpression alloc]initWithPattern:@"[\\^\\.\\+\\-\\*\\/]$|\\($" options:0 error:nil];
    
    self.Textonscreen.text=@"0";
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)Bracketspush:(id)sender {
    if(([self.Textonscreen.text characterAtIndex:0] == '0') && ([self.Textonscreen.text length] == 1))
    self.Textonscreen.text = @"";
    
    if([sender tag] == 101)
    { NSUInteger invalid =[self.regexbracketopen numberOfMatchesInString:self.Textonscreen.text options:0 range:NSMakeRange(0,[self.Textonscreen.text length])];
        BOOL isInvalid = invalid;
        if (isInvalid )
        {
            return;}
        self.BracketsOpened++;
        self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@"("];
    }
    
    if([sender tag] == 102)
    {
        NSUInteger invalid =[self.regexbracketclosed numberOfMatchesInString:self.Textonscreen.text options:0 range:NSMakeRange(0,[self.Textonscreen.text length])];
        BOOL isInvalid = invalid;
        if (isInvalid )
        {
            return;}
        else
            if (self.BracketsClosed < self.BracketsOpened) {
                
           
        self.BracketsClosed++;
             self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@")"];
        
            }}

    
}
- (IBAction)Calculate:(id)sender {

    if (self.BracketsOpened > self.BracketsClosed) {
        for (int i = 0; i < self.BracketsOpened - self.BracketsClosed; i++)
            self.Textonscreen.text = [self.Textonscreen.text stringByAppendingString:@")"];
    }
    NSString *Text = self.Textonscreen.text;
    
    self.Textonscreen.text = [Text stringByReplacingOccurrencesOfString:@"^" withString:@"**"];
    NSExpression *expression = [NSExpression expressionWithFormat: self.Textonscreen.text];
  self.Textonscreen.text = [([expression expressionValueWithObject:nil context:nil]) stringValue];
                         
                         }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
