//
//  InputValidator.h
//  RPLCalculator
//
//  Created by Admin on 02.12.14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InputValidator : NSObject

-(NSMutableAttributedString*)ValidateAttributedString: (NSMutableAttributedString*)attributedString result:(BOOL*)isValid;

@end
