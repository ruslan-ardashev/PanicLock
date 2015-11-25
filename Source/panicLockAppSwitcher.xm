////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


@protocol SBAppSwitcherIconControllerDelegate <NSObject>
-(void)switcherIconScrollerDidEndScrolling:(id)switcherIconScroller;
-(void)switcherIconScrollerBeganPanning:(id)panning;
-(BOOL)switcherIconScroller:(id)scroller shouldHideIconForDisplayLayout:(id)displayLayout;
-(void)switcherIconScroller:(id)scroller activate:(id)activate;
-(void)switcherIconScroller:(id)scroller contentOffsetChanged:(float)changed;
@end

@interface SBDisplayLayout : NSObject <NSCopying>
@property(readonly, nonatomic) NSArray *displayItems; // @synthesize displayItems=_displayItems;
@end

@interface SBDisplayItem : NSObject <NSCopying>
@property(readonly, nonatomic) NSString *displayIdentifier; // @synthesize displayIdentifier=_displayIdentifier;
@end


%hook SBAppSwitcherIconController

- (void)setDisplayLayouts:(NSArray* )displayLayouts { 

	// %log; 

	if ([panicLockData isPanicLockActive]) {

		NSMutableArray *argArray = [NSMutableArray arrayWithArray:displayLayouts];
		NSMutableArray *removeArray = [NSMutableArray array];

		// Iterating Variables
		int i=0;
		NSString *appName;

		for (id Object in displayLayouts) {

			appName = [[Object displayItems][0] displayIdentifier];

			if ([panicLockData isAppForbiddenForName:appName]) {

				[removeArray addObject:Object];

			}

			i++;

		}

		[argArray removeObjectsInArray:removeArray];

		%orig(argArray);

	}

	else {

		%orig;

	}

}

%end


%hook SBAppSwitcherPageViewController

- (void)setDisplayLayouts:(NSArray* )displayLayouts { 

	// %log; 

	if ([panicLockData isPanicLockActive]) {

		NSMutableArray *argArray = [NSMutableArray arrayWithArray:displayLayouts];
		NSMutableArray *removeArray = [NSMutableArray array];

		// Iterating Variables
		int i=0;
		NSString *appName;

		for (id Object in displayLayouts) {

			appName = [[Object displayItems][0] displayIdentifier];

			if ([panicLockData isAppForbiddenForName:appName]) {

				[removeArray addObject:Object];

			}

			i++;

		}

		[argArray removeObjectsInArray:removeArray];

		%orig(argArray);

	}

	else {

		%orig;

	}

}

%end


%hook SBAppSwitcherPeopleViewController

-(void)tappedExpandCollapseForItem:(id)item { 

	if ([panicLockData isPanicLockActive]) {

		return;

	}

	else {

		%orig;

	}

}

%end






