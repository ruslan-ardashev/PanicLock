////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"

@interface SBApplicationIcon
- (void)launchFromLocation:(int)arg;
- (id)leafIdentifier;
@end

%hook SBApplicationIcon

- (void)launchFromLocation:(int)arg1 {

	BOOL panicLockActive = [panicLockData isPanicLockActive];
	
	if (panicLockActive) {

		if ([panicLockData isAppForbiddenForName:[self leafIdentifier]]) {

			return;

		}

		else {

			%orig;

		}

	}

	else {

		%orig;
		
	}

}

%end

