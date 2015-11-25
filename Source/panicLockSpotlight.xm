////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


%hook SBSearchViewController

-(void)_searchFieldReturnPressed { 

	if ([panicLockData isPanicLockActive]) {

		return;

	}

	else {

		%orig; 

	}

}

-(void)_searchFieldEditingChanged { 

	if ([panicLockData isPanicLockActive]) {

		return;

	}

	else {

		%orig; 

	}

}

%end









