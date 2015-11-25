////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


%hook SBNewsstand

+ (BOOL)newsstandStoreIsAvailable { 

	if ([panicLockData isPanicLockActive]) {

		// NSLog(@"ra86: swizzled is newsstandStoreIsAvailable.");
		return NO;

	}

	else {

		return %orig;

	}

}

%end



