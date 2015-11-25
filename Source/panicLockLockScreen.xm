////////////////////////////////////////////////////////////////////////////////////////////
//
// panicLockPro by Ruslan Ardashev 
// ruslan.ardashev@duke.edu
// www.ruslanArdashev.com
// Copyright 2015
//
////////////////////////////////////////////////////////////////////////////////////////////

#include "panicLockData.h"


@class UIGestureRecognizer, UITouch, SBAwayViewPluginController, UIGestureRecognizer, SBAwayBulletinListItem, UIScrollView, SBLockScreenActionContext;


@protocol SBCoordinatedPresenting <NSObject>
@property(readonly, nonatomic) unsigned long long hintEdge;
@property(readonly, nonatomic) double hintDisplacement;
@property(readonly, nonatomic) long long coordinatedPresentingControllerIdentifier;
- (void)abortAnimatedTransition;
- (void)endTransitionWithVelocity:(struct CGPoint)arg1 wasCancelled:(_Bool)arg2 completion:(void (^)(_Bool))arg3;
- (void)updateTransitionWithTouchLocation:(struct CGPoint)arg1 velocity:(struct CGPoint)arg2;
- (void)beginPresentationWithTouchLocation:(struct CGPoint)arg1;
- (_Bool)isPresentingControllerTransitioning;

@optional
@property(readonly, nonatomic) NSSet *tapExcludedViews;
@property(readonly, nonatomic) NSSet *conflictingGestures;
@property(readonly, nonatomic) NSSet *gestures;
- (_Bool)shouldBeginHintForGesture:(UIGestureRecognizer *)arg1;
- (void)reenableGestureRecognizer:(UIGestureRecognizer *)arg1;
- (void)cancelGestureRecognizer:(UIGestureRecognizer *)arg1;
- (void)treatCurrentPositionAsBoundaryforGesture:(UIGestureRecognizer *)arg1;
@end

@protocol SBPresentingDelegate <NSObject>
- (void)presentingControllerDidFinishPresentation:(id <SBCoordinatedPresenting>)arg1;
- (void)presentingController:(id <SBCoordinatedPresenting>)arg1 willHandleGesture:(UIGestureRecognizer *)arg2;
- (_Bool)presentingController:(id <SBCoordinatedPresenting>)arg1 gestureRecognizerShouldBegin:(UIGestureRecognizer *)arg2;
- (_Bool)presentingController:(id <SBCoordinatedPresenting>)arg1 gestureRecognizer:(UIGestureRecognizer *)arg2 shouldReceiveTouch:(UITouch *)arg3;

@optional
- (void)presentingController:(id <SBCoordinatedPresenting>)arg1 conflictingGestureDidEnd:(UIGestureRecognizer *)arg2;
- (void)presentingController:(id <SBCoordinatedPresenting>)arg1 conflictingGestureDidBegin:(UIGestureRecognizer *)arg2;
@end

@protocol SBLockScreenNotificationListDelegate <NSObject>
- (void)authenticateForNotificationActionWithCompletion:(void (^)(_Bool))arg1;
- (void)addCoordinatedPresentingController:(id <SBCoordinatedPresenting>)arg1;
- (void)removeCoordinatedPresentingController:(id <SBCoordinatedPresenting>)arg1;
- (void)dismissFullscreenBulletinAlertWithItem:(SBAwayBulletinListItem *)arg1;
- (void)modifyFullscreenBulletinAlertWithItem:(SBAwayBulletinListItem *)arg1;
- (void)presentFullscreenBulletinAlertWithItem:(SBAwayBulletinListItem *)arg1;
- (UIScrollView *)lockScreenScrollView;
- (void)notificationListBecomingVisible:(_Bool)arg1;
- (void)attemptToUnlockUIFromNotification;
- (void)bannerEnablementChanged;
@end


%hook SBLockScreenNotificationListController

-(id)_newItemForBulletin:(id)bulletin { 

	if ([panicLockData isPanicLockActive]) {

		return nil;

	}

	else {

		return %orig;

	}

}

%end

%hook SBLockScreenViewController

-(BOOL)suppressesControlCenter { 

	if ([panicLockData isPanicLockActive]) {

		return YES;

	}

	else {

		return %orig;

	}

}

-(BOOL)suppressesNotificationCenter { 

	if ([panicLockData isPanicLockActive]) {

		return YES;

	}

	else {

		return %orig;

	}

}

%end





