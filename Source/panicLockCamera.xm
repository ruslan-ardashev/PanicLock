////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


#define FILE_PATH @"/var/mobile/Library/Preferences/com.ruslan.panicLockProiOS8Prefs.plist"


@class CAMImageWell;

@interface CAMBottomBar : NSObject
@property(retain, nonatomic) CAMImageWell *imageWell; // @synthesize imageWell=_imageWell;
- (BOOL)accessStateFromDisk;
@end


static CAMImageWell *savedWell;


%hook CAMBottomBar

%new(B)
- (BOOL)accessStateFromDisk {

    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:FILE_PATH];

	if (prefs == nil) {

		// NSLog(@"ra86: Prefs nil. returning.");
		return YES;

	}

	else {

		NSNumber *isEnabled_NSNumber = [prefs objectForKey:@"isEnabled_NSNumber"];
		BOOL isPanicLockActive = [isEnabled_NSNumber boolValue];

		return isPanicLockActive;
		// NSLog(@"ra86: Loaded paniclockpro iOS 8 prefs, prev. lock status: %d", isPanicLockActive);

	}

}

- (int)orientation { 

	BOOL panicLockActive = [self accessStateFromDisk];
	CAMImageWell *currWell = [self imageWell];

	if (panicLockActive) {

		// Two use cases.
		// 1. panicLock was NOT just active. a fresh imagewell. save it! then get rid of it.
		if (currWell != nil) {

			// Check before saving. Edge case --> What if we already ran camera with panicLock disabled first? savedWell exists.
			if (savedWell == nil) {

				savedWell = currWell;

			}

			// Get rid of it.
			[self setImageWell:nil];

		}

		// 2. panicLock was, and still is active. don't hurt the poor thing any more.
		else {

			// currWell is already nil. No need to set it again.

		}

		return %orig;

	}

	// PanicLock NOT active. should have a functioning imageWell. it has always been saved by panicLock.
	else {

		// Else, panicLock not active, but just was, and there is no image well.
		// currWell = nil.
		if (currWell == nil) {		

			// If we have saved state, restore it!
			if (savedWell != nil) {

				[self setImageWell:savedWell];

				// Clean up for next run!
				savedWell = nil;

			}

		}

		return %orig;

	}
	
}

%end

