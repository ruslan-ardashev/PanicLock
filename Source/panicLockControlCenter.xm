////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


%hook SBUIController

-(void)handleShowControlCenterSystemGesture:(id)gesture { 

	if ([panicLockData isPanicLockActive]) {

		// NSLog(@"ra86: swizzled show control center");

	}

	else {

		%orig;

	}

}

%end



