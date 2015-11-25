////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2014
//
////////////////////////////////////////////////////////////////////////////////////////////

#import <libactivator/libactivator.h>

#define FILE_PATH @"/var/mobile/Library/Preferences/com.ruslan.paniclockproprefs.plist"

// @interface SBAppSliderController
// - (unsigned long long)sliderScrollerItemCount:(id)arg1;		// Apps' images, icons still appear
// - (void)_layout;
// @end

// @interface NSNotificationCenter : NSObject
// + (id)defaultCenter;
// - (_Bool)isEmpty;
// // - (id)addObserverForName:(id)arg1 object:(id)arg2 queue:(id)arg3 usingBlock:(id)arg4;
// // - (void)postNotificationName:(id)arg1 object:(id)arg2 userInfo:(id)arg3;
// // - (void)postNotificationName:(id)arg1 object:(id)arg2;
// - (void)postNotification:(id)arg1;
// - (void)removeObserver:(id)arg1 name:(id)arg2 object:(id)arg3;
// - (void)removeObserver:(id)arg1;
// - (void)addObserver:(id)arg1 selector:(SEL)arg2 name:(id)arg3 object:(id)arg4;
// - (id)description;
// - (void)dealloc;
// - (void)finalize;
// - (id)init;
// @end

@interface SBUIController : NSObject
// - (id)_appSliderController; 									// nope. returning nil does nothing.
// - (id)switcherController; 	 								// nope. returning nil does nothing.
// - (void)appSwitcherWantsToDismissImmediately:(id)arg1;
// - (void)appSwitcher:(id)arg1 wantsToActivateApplication:(id)arg2;

// - (_Bool)_allowSwitcherGesture;								// nope. returning nil does nothing.
// - (void)_dismissAppSwitcherImmediately;
// - (id)switcherWindow;										// nope. called in background multiple times. not relevant to preventing activating the switcher.
- (_Bool)_activateAppSwitcherFromSide:(int)arg1;				// SUCCESS. returning false instead of the original method successfully prevents activating the switcher.
// - (_Bool)handleMenuDoubleTap;
// - (void)_toggleSwitcher;
// - (id)_toggleSwitcherAfterLaunchApp;

// Test later. Maybe when blocking the control center as well. Might not even be necessary, but can launch apps like calc from there...
// - (_Bool)allowsShowControlCenterGesture;


// Notification Center
// - (void)_hideNotificationCenterTabControl;
// - (_Bool)shouldShowNotificationCenterTabControlOnFirstSwipe;
// - (void)_showNotificationsGestureBeganWithLocation:(struct CGPoint)arg1;
- (void)handleShowNotificationsSystemGesture:(id)arg1;			// SUCCESS. returning instead of the original method successfully prevents activating the NSNotificationCenter.

@end

// @interface SBAppSliderController : UIViewController
// - (void)loadView;											// Interfering here by not calling this crashes Springboard.
// - (unsigned long long)sliderScrollerItemCount:(id)arg1;		// Interfering here by returning 0 causes no app images to display.
// @end

@interface SBApplicationIcon
- (void)launchFromLocation:(int)arg;
// - (id)displayName;
- (id)leafIdentifier;
@end

// @interface SBNotificationCell : NSObject
// - (UIButton *)actionButton;									// Nope. returning nil still allows one to open notifications that appear.
// @end

@interface CAMImageWell
- (id)initWithFrame:(id)arg1;									// Interfering with this results in no camera roll in Camera.app
@end

@interface SBBulletinBannerItem : NSObject
+(id)itemWithSeedBulletin:(id)seedBulletin additionalBulletins:(id)bulletins andObserver:(id)observer;
+(id)itemWithBulletin:(id)bulletin andObserver:(id)observer;
-(BOOL)overridesQuietMode;
-(BOOL)isCritical;
-(BOOL)inertWhenLocked;
-(BOOL)isVIP;
-(id)attachmentImage;
-(id)attachmentText;
-(id)iconImage;
-(id)sourceDate;
-(id)message;
-(id)title;
-(id)pullDownNotification;
-(BOOL)canShowInAssistant;
-(id)sortDate;
-(id)seedBulletin;
-(id)action;
// -(id)sound;
// -(void)_setSound;
// -(unsigned)accessoryStyle;
// -(id)_appName;
// -(id)additionalBulletins;
// -(void)dealloc;
-(id)_initWithSeedBulletin:(id)seedBulletin additionalBulletins:(id)bulletins andObserver:(id)observer;
@end

static BOOL DEBUG_TWEAK = false;
static BOOL isEnabled = false;
static NSNumber *isEnabled_NSNumber;
// static NSArray *protectedApplications;

////////////////////////////////////////////////////////////////////////////////////////////
// Static Methods
////////////////////////////////////////////////////////////////////////////////////////////

static void loadPrefs() {

	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:FILE_PATH];

	if (prefs) {

		isEnabled_NSNumber = [prefs objectForKey:@"isEnabled_NSNumber"];
		isEnabled = [isEnabled_NSNumber boolValue];

		if (DEBUG_TWEAK) NSLog(@"loadPrefs(): Success loading previous lock status: %d", isEnabled);		
	} 

	else {
		isEnabled = false;
		if (DEBUG_TWEAK) NSLog(@"Error loading previous lock status.");
	}

	if (DEBUG_TWEAK) NSLog(@"loadPrefs: prefs dictionary: %@", prefs);

	[prefs release];

}


////////////////////////////////////////////////////////////////////////////////////////////
// Hooked Methods
////////////////////////////////////////////////////////////////////////////////////////////

%hook SBBulletinBannerItem

+(id)itemWithSeedBulletin:(id)seedBulletin additionalBulletins:(id)bulletins andObserver:(id)observer {
	if (isEnabled) {
		if (DEBUG_TWEAK) NSLog(@"SBBulletinBannerItem: Enabled! Interfering!");
		return nil;
	} else {
		return %orig(seedBulletin, bulletins, observer);
	}
}

+(id)itemWithBulletin:(id)bulletin andObserver:(id)observer {
	if (isEnabled) {
		if (DEBUG_TWEAK) NSLog(@"SBBulletinBannerItem: Enabled! Interfering!");
		return nil;
	} else {
		return %orig(bulletin, observer);
	}
}

-(id)_initWithSeedBulletin:(id)seedBulletin additionalBulletins:(id)bulletins andObserver:(id)observer {
	if (isEnabled) {
		if (DEBUG_TWEAK) NSLog(@"SBBulletinBannerItem: Enabled! Interfering!");
		return nil;
	} else {
		return %orig(seedBulletin, bulletins, observer);
	}
}

%end

// %hook NSNotificationCenter

// - (_Bool)isEmpty {

// 	if (isEnabled) {
// 		if (DEBUG_TWEAK) NSLog(@"NSNotificationCenter: panicLock enabled! Interfering.");
// 		return true;
// 	}

// 	else {
// 		return %orig;
// 	}

// }

// %end


%hook SBUIController

- (_Bool)_activateAppSwitcherFromSide:(int)arg1 {

	if (isEnabled) {
		if (DEBUG_TWEAK) NSLog(@"SBUIController: isEnabled. Interfere.");
		return false;
	}

	else {
		if (DEBUG_TWEAK) NSLog(@"SBUIController: normal operation!");
		return %orig(arg1);
	}

}

// - (void)_hideNotificationCenterTabControl {
// 	%log;
// 	%orig;
// }

// - (_Bool)shouldShowNotificationCenterTabControlOnFirstSwipe  {
// 	%log;
// 	return %orig;
// }

// - (void)_showNotificationsGestureBeganWithLocation:(struct CGPoint)arg1 {
// 	%log;
// 	return %orig(arg1);

// }

- (void)handleShowNotificationsSystemGesture:(id)arg1 {

	if (isEnabled) {
		if (DEBUG_TWEAK) NSLog(@"SBUIController: Enabled! Interfering with NSNotificationCenter show.");
	}

	else {
		%orig(arg1);
	}
}


%end


%hook SBApplicationIcon

- (void)launchFromLocation:(int)arg1 {

	if (isEnabled) {

		NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:FILE_PATH];
		NSString *application = [@"App-" stringByAppendingString:[self leafIdentifier]];
		BOOL forbidLaunch = [[prefs objectForKey:application] boolValue];

		if (DEBUG_TWEAK) NSLog(@"SBApplicationIcon: \nPrefs: %@\napplication: %@\nforbidLaunch: %d", prefs, application, forbidLaunch); 

		if (!forbidLaunch) {

			%orig(arg1);

		}

		[prefs release];

	}

	else {
		%orig(arg1);
	}

}

%end

%hook CAMImageWell

- (id)initWithFrame:(id)arg1 {

	if (isEnabled) {

		if (DEBUG_TWEAK) NSLog(@"Tweak/CAMImageWell: interfering with initWithFrame");
		return nil;
		
	} 

	else {
		return %orig(arg1);
	}	

}

%end 

%ctor 
{
    
    loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.ruslan.paniclockproprefs/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);

}


////////////////////////////////////////////////////////////////////////////////////////////
//
// Activator Portion
//
////////////////////////////////////////////////////////////////////////////////////////////

@interface panicLockProListener : NSObject <LAListener>
@end
 

@implementation panicLockProListener
 
+ (void)load {

	if ([LASharedActivator isRunningInsideSpringBoard]) {
		[LASharedActivator registerListener:[self new] forName:@"com.ruslan.paniclockpro"];
	}

}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{

	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:FILE_PATH];

	if (DEBUG_TWEAK) NSLog(@"activatorReceiveEvent: Detected activator action.");

	if (isEnabled) {

		isEnabled = false;
		if (DEBUG_TWEAK) NSLog(@"activatorReceiveEvent: isEnabled was true. Set it to false.");

	}

	else {	

		isEnabled = true;
		if (DEBUG_TWEAK) NSLog(@"activatorReceiveEvent: isEnabled was false. Set it to true.");

	}

	isEnabled_NSNumber = [NSNumber numberWithBool:isEnabled];

	if (DEBUG_TWEAK) NSLog(@"activatorReceiveEvent: Setting isEnabled_NSNumber to %d", isEnabled, nil);

	if (prefs != nil) {

		[prefs setObject:isEnabled_NSNumber forKey:@"isEnabled_NSNumber"];
		[prefs writeToFile:FILE_PATH atomically:YES];
		if (DEBUG_TWEAK) NSLog(@"activatorReceiveEvent: Prefs non-nil, wrote isEnabled to it! %@", isEnabled_NSNumber);

	} 

	else {

		prefs = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithBool:isEnabled], @"isEnabled_NSNumber", nil];
		[prefs writeToFile:FILE_PATH atomically:YES];
		if (DEBUG_TWEAK) NSLog(@"activatorReceiveEvent: prefs was nil. Created a isEnabled_NSNumber and wrote it. Prefs is now: %@", prefs);
		
	}

	if (DEBUG_TWEAK) NSLog(@"activatorReceiveEvent: prefs dictionary:\n%@", prefs);
 
	[event setHandled:YES]; // To prevent the default OS implementation

	[prefs release];

	return;
}
 
- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event
{
		
	if (DEBUG_TWEAK) NSLog(@"activatorAbortEvent called.");

	// Dismiss your plugin
	if (DEBUG_TWEAK) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"LASharedActivator." 
										 	  		message:@"abortEvent Called." 
										 	  		delegate:self 
										 	  		cancelButtonTitle:@"Okay" 
										 	  		otherButtonTitles:nil];
    	[alert show];
    	[alert release];
	}

}

@end





