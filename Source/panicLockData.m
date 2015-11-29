////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#import "panicLockData.h"

#define FILE_PATH @"/var/mobile/Library/Preferences/com.ruslan.panicLockProiOS8Prefs.plist"


// Static Vars
static BOOL isPanicLockActive;

// Static Methods
static void loadPrefs() {

	// NSLog(@"ra86: Loading paniclockpro iOS 8 prefs.");

	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:FILE_PATH];

	if (prefs == nil) {

		// NSLog(@"ra86: Prefs nil. returning.");
		return;

	}

	else {

		NSNumber *isEnabled_NSNumber = [prefs objectForKey:@"isEnabled_NSNumber"];
		isPanicLockActive = [isEnabled_NSNumber boolValue];
		// NSLog(@"ra86: Loaded paniclockpro iOS 8 prefs, prev. lock status: %d", isPanicLockActive);

	}

}


@implementation panicLockData

// Runs on initialization to load previous lock status
+ (void)initialize {

	 loadPrefs();
	 CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.ruslan.paniclockproios8prefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);

	 
}

+ (BOOL)isPanicLockActive {

	// NSLog(@"ra86: panicLockData.m: accessed isPanicLockActive called. returns: %d", isPanicLockActive);
	return isPanicLockActive;

}

+ (void)flipPanicLockStatus {

	// Flip Status
	if (isPanicLockActive) {

		isPanicLockActive = false;

	}

	else {

		isPanicLockActive = true;

	}

	// Write this status to disk. Done so that a malicious user can't 
	// bypass panicLock simply by restarting the device
	[panicLockData saveStatusToDisk:isPanicLockActive];

}

+ (BOOL)isAppForbiddenForName:leafIdentifier {

	BOOL returnValue;

	NSMutableDictionary *prefs =  [[NSMutableDictionary alloc] initWithContentsOfFile:FILE_PATH];

	// nil checking of string passed AND prefs reading from disk
	if ((leafIdentifier == nil) || (prefs == nil)) {

		return YES;

	}

	NSString *application = [@"App-" stringByAppendingString:leafIdentifier];

	returnValue = [[prefs objectForKey:application] boolValue];

	return returnValue;

}

+ (void)saveStatusToDisk:(BOOL)statusToSave {

	// Package status to save into NSNumber for saving
	NSNumber *isEnabled_NSNumber = [NSNumber numberWithBool:statusToSave];

	// Get save location
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:FILE_PATH];

	// Handle Initializing Case
	if (prefs == nil) {

		[panicLockData displayWelcomeMessage];
		prefs = [[NSMutableDictionary alloc] initWithObjectsAndKeys: isEnabled_NSNumber, @"isEnabled_NSNumber", nil];

	}

	// Write to save location
	[prefs setObject:isEnabled_NSNumber forKey:@"isEnabled_NSNumber"];
	[prefs writeToFile:FILE_PATH atomically:YES];
	// NSLog(@"ra86: Successfully wrote state: %d to file.", [isEnabled_NSNumber boolValue]);

}

+ (void)displayWelcomeMessage {

	// UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to panicLock [Pro] for iOS 8"
	// 						  					    message:@"Preference file created. panicLock [Pro] will now remember lock status between reboots for security purposes."
	// 						 					   delegate:nil
	// 			 						  cancelButtonTitle:@"Got it, thanks!"
	// 			 						  otherButtonTitles:nil];

	// [alert show];
	// [alert release];

}

@end


















