////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


%hook SBBulletinBannerController

-(void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned)feed { 
	
	if ([panicLockData isPanicLockActive]) {

		return;

	}	

	else {

		%orig; 
		
	}
	
}

%end


