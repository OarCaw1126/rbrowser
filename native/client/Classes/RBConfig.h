#import <Foundation/Foundation.h>

#define RBNativeVersion @"20260720-2"
#define RBDefaultServerURL @"https://surf.seg6.space"
#define RBDefaultPassword @"linuxwifi"
#define RBLogDirectory @"/var/mobile/Library/Surf"
#define RBLogFile @"/var/mobile/Library/Surf/surf.log"

// NSUserDefaults keys (settings screen).
#define RBDefaultsServerURLKey @"RBServerURL"
#define RBDefaultsPasswordKey @"RBPassword"
#define RBDefaultsVideoKey @"RBVideoEnabled" // NSNumber bool; absent = enabled
#define RBDefaultsStreamProfileKey @"RBStreamProfile" // sharp/smooth/balanced/fast/potato/max
#define RBDefaultsServersKey @"RBServers" // [{title,url}]
#define RBDefaultsLastPasteboardKey @"RBLastPasteboard" // last URL offered from the pasteboard
#define RBDefaultsReaderNightKey @"RBReaderNight" // NSNumber bool; reader dark mode
