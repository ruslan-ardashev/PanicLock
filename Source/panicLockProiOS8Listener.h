////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////
//
// Activator Portion
//
////////////////////////////////////////////////////////////////////////////////////////////

#import <libactivator/libactivator.h>
#import "panicLockData.h"

@interface panicLockProiOS8Listener : NSObject <LAListener>
+ (void)load;
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event;
- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event;
@end
