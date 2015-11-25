#import <Preferences/Preferences.h>

@interface panicLockProPrefsListController: PSListController {
}
@end

@implementation panicLockProPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"panicLockProPrefs" target:self] retain];
	}
	return _specifiers;
}

-(void) sendEmail
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:ruslan.ardashev@duke.edu?subject=panicLockPro"]];
}

-(void) openInstructions
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=0jrsolwbXxM"]];
}

-(void) openYoutubeChannel
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/user/Ruslan120101"]];
}

@end

// vim:ft=objc
