///Users/andriiv/Desktop/TestsProjects/Test2/
//  T2ViewController.m
//  Test2
//
//  Created by Andrii V. on 26.11.14.
//  Copyright (c) 2014 Andrii V. All rights reserved.
//

#import "T2ViewController.h"

@interface T2ViewController ()

@property (strong, nonatomic) NSString * OutputString;

@property (strong, nonatomic) NSString * InputString;

@property (nonatomic) BOOL isDot;

@end

@implementation T2ViewController

NSInteger NumberOfGaps;

@synthesize OutputString,InputString,textf,lab;

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

- (IBAction)DigitAction:(id)sender {
    
    if([textf.text characterAtIndex:([textf.text length]-1)]=='0'){
        textf.text= [textf.text substringToIndex:[textf.text length]-1];
        NSInteger I1 = self.IsBool;
        if((I1==1)||(I1==0)||(I1==4))textf.text= [textf.text stringByAppendingString:@"0"];
    }
    
    NSInteger I = self.IsBool;
    
    if(I!=6)
    textf.text= [textf.text stringByAppendingString: [sender currentTitle]];
    
}
- (IBAction)MinosOperation:(id)sender {
    NSInteger I = self.IsBool;
    
    if((I==1)||(I==0)||(I==6)||(I==5)||(I==7)){
        textf.text= [textf.text stringByAppendingString: [sender currentTitle]];
        _isDot =TRUE;
    }
}
- (IBAction)OperationAction:(id)sender {
    
    NSInteger I = self.IsBool;
    
    if((I==1)||(I==0)||(I==6)){
        textf.text= [textf.text stringByAppendingString: [sender currentTitle]];
        _isDot =TRUE;
    }
}
- (IBAction)ZeroButtonClick:(id)sender {
    
    if([textf.text characterAtIndex:([textf.text length]-1)]=='0'){
        textf.text= [textf.text substringToIndex:[textf.text length]-1];
        NSInteger I1 = self.IsBool;
        if((I1==1)||(I1==0)||(I1==4))textf.text= [textf.text stringByAppendingString:@"0"];
    }
        
    NSInteger I = self.IsBool;
    
    if(I!=6)textf.text= [textf.text stringByAppendingString: [sender currentTitle]];
    
}
- (IBAction)DotButtonClick:(id)sender {
    
    NSInteger I = self.IsBool;
    if(((I==1)||(I==0))&&(_isDot)){
        textf.text= [textf.text stringByAppendingString: [sender currentTitle]];
        _isDot=FALSE;
    }
    
}
- (IBAction)LsftScopeClick:(id)sender {
    NSInteger I = self.IsBool;
    if((I==2)||(I==3)||(I==7)||(I==5)){
        textf.text= [textf.text stringByAppendingString: [sender currentTitle]];
        NumberOfGaps++;
        _isDot =TRUE;
    }
    
}
- (IBAction)RightScopeClick:(id)sender {
    NSInteger I = self.IsBool;
    if(((I==1)||(I==0)||(I==6))&&(NumberOfGaps>0)){
        textf.text= [textf.text stringByAppendingString: [sender currentTitle]];
        NumberOfGaps--;
        _isDot =TRUE;
    }
   
}
- (IBAction)NewClick:(id)sender {
    textf.text=@"";
    _isDot =FALSE;
    
}
- (IBAction)CanselClick:(id)sender {
    
    if([textf.text characterAtIndex: (textf.text.length  -1)]=='(' )NumberOfGaps--;
    if([textf.text characterAtIndex: (textf.text.length  -1)]==')' )NumberOfGaps++;
    if([textf.text characterAtIndex: (textf.text.length  -1)]=='.' )_isDot=TRUE;
    
    if(textf.text.length!=0)textf.text= [textf.text substringToIndex:[textf.text length]-1];
    
}

-(NSInteger)IsBool{
    NSString *STR=textf.text;
    NSInteger I=0;
    NSInteger Last = STR.length-1;
  
    if(STR.length==0){
        _isDot=TRUE;
        NumberOfGaps=0;
        return 7;
    }
    switch ([STR characterAtIndex:Last]) {
        case '+':
            I=2;
            break;
        case '*':
            I=2;
            break;
        case '/':
            I=2;
            break;
        case '-':
            I=3;
            break;
        case '1':
            I=1;
            break;
        case '2':
            I=1;
            break;
        case '3':
            I=1;
            break;
        case '4':
            I=1;
            break;
        case '5':
            I=1;
            break;
        case '6':
            I=1;
            break;
        case '7':
            I=1;
            break;
        case '8':
            I=1;
            break;
        case '9':
            I=1;
            break;
        case '0':
            I=0;
            break;
        case '.':
            I=4;
            break;
        case '(':
            I=5;
            break;
        case ')':
            I=6;
            break;
        default:
            break;
    }
    
    return I;
}

- (IBAction)calculate:(id)sender {
    
    if(NumberOfGaps==0){
        if(textf.text.length!=0)[self setInputString:textf.text];
        else setInputString:textf.text = @"0";
        
        [self setOutputString:self.InputString];
    
        _DivadeZero = TRUE;
    
        double d=0.0;
    
        d=[self Equation:InputString];
    
        OutputString = [NSString stringWithFormat:@"%f",d];
    
        if(_DivadeZero==FALSE)OutputString=@"DIVADE TO 0";
        
        lab.text = OutputString;
    }
   
}
-(double)Multiplier:(NSString *)STR{
    
    if([self IsStringDouble:(STR)]){
        return [STR doubleValue];
    }
    
    NSRange Range;
    if (([STR characterAtIndex: 0]=='(')&&([STR characterAtIndex: STR.length-1]==')') ) {
        Range = NSMakeRange(1, STR.length-2);
    }
    else Range = NSMakeRange(0, STR.length);
    NSString *NewSTR= [STR substringWithRange:Range];
    
    double res =[self Equation:NewSTR];
    
    if(_DivadeZero == FALSE)return 0;
    
    return res;
    
}
-(double)Summand:(NSString *)STR{
    
    NSInteger I1=0,I2=0;
    
    for(I1=0;I1<STR.length;I1++) {
        if([STR characterAtIndex: I1]=='('){
            I2++;
        }
        if([STR characterAtIndex: I1]==')'){
            I2--;
        }
        if((I2==0)&&(([STR characterAtIndex: I1]=='*')||([STR characterAtIndex: I1]=='/'))){
            break;
        }
    }
    
    if(I1==STR.length)return [self Multiplier:STR];
    
    NSString *S1 = [STR substringToIndex:I1];
    NSString *S2 = [STR substringFromIndex:(I1+1)];
    
    double Mult1 = [self Summand:S1];
    
    if(_DivadeZero == FALSE)return 0;
    
    double Mult2 = [self Summand:S2];
    
    if(_DivadeZero == FALSE)return 0;
    
    if([STR characterAtIndex: I1]=='/'){
        if(Mult2!=0)return Mult1/Mult2;
        
        _DivadeZero = FALSE;
        
        return 0;
    }
    return Mult1*Mult2;
}

-(double)Equation:(NSString *)STR{
    
    NSInteger I1=0,I2=0;
    
    for(I1=0;I1<STR.length;I1++) {
        if([STR characterAtIndex: I1]=='('){
            I2++;
        }
        if([STR characterAtIndex: I1]==')'){
            I2--;
        }

        if((I2==0)&&(([STR characterAtIndex: I1]=='+')||(([STR characterAtIndex: I1]=='-')&&(I1!=0)))){
            break;
        }
    }
    
    if(I1==STR.length)return [self Summand:STR];
    
    if(_DivadeZero == FALSE)return 0;
    
    NSString *S1 = [STR substringToIndex:I1];
    
    NSString *S2 = [STR substringFromIndex:(I1+1)];
    
    double Mult1 = [self Equation:S1];
    
    if(_DivadeZero == FALSE)return 0;
    
    double Mult2 = [self Equation:S2];
    
    if(_DivadeZero == FALSE)return 0;
    
    if([STR characterAtIndex: I1]=='+')return Mult1+Mult2;
    
    return Mult1-Mult2;
}

-(BOOL)IsStringDouble:(NSString *)STR{

    NSInteger I1=0;
    if([STR length]){
        if([STR characterAtIndex: I1]=='-')I1++;
        for(NSInteger I=I1;I<STR.length;I++){
            unichar c =[STR characterAtIndex: I];
            if((c!='.')&&((c<'0')||(c>'9'))){
                return FALSE;
            }
        }
    }
    return TRUE;
}

@end
