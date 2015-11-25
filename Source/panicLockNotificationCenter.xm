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

-(void)handleShowNotificationsSystemGesture:(id)gesture { 

	BOOL isPanicLockActive = [panicLockData isPanicLockActive];

	if (isPanicLockActive) {

		// NSLog(@"ra86: panicLock block notification center.");

	}
	
	else {

		%orig; 

	}

}

%end

