////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


%hook SBAssistantController

+(BOOL)shouldEnterAssistant { 

	if ([panicLockData isPanicLockActive]) {

		return NO;

	}

	else {

		return %orig;

	}

}

%end




