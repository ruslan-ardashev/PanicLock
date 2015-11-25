#import <Preferences/Preferences.h>

@interface panicLockProiOS8PrefsListController: PSListController {
}
@end

@implementation panicLockProiOS8PrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"panicLockProiOS8Prefs" target:self] retain];
	}
	return _specifiers;
}
-(void) sendEmail {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:ruslan.ardashev@duke.edu?subject=panicLockPro"]];
}

-(void) openInstructions {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=0jrsolwbXxM"]];
}

-(void) openDemo {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=B0uuQs2-Ems"]];
}

-(void) openYoutubeChannel {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/channel/UC2GzUE7JdXrD_HlVMg9_c6A"]];
}

@end

// vim:ft=objc
