//
//  Stack.h
//  aocalculator
//
//  Created by Alex Ozun on 26.11.14.
//  Copyright (c) 2014 Alex Ozun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject <NSFastEnumeration>
@property (nonatomic, assign, readonly) NSUInteger count;

- (id)initWithArray:(NSArray*)array;

- (void)pushObject:(id)object;
- (void)pushObjects:(NSArray*)objects;
- (id)popObject;
- (id)peekObject;

@end
