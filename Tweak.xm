#import "Tweak.h"
 
/*
 *
 * Thank you:
 * AlexPNG (Shake2Toggle), Skitty(NightShift), Kritanta(Shakelight), gilshahar(DoNotDisturb)
 *
 */


/* =-=-=-=-=-=-= Toggle Functions =-=-=-=-=-=-= */

void toggleAirplaneMode() {
    if ([[%c(SBAirplaneModeController) sharedInstance] isInAirplaneMode]) {
        [[%c(SBAirplaneModeController) sharedInstance] setInAirplaneMode:NO];
    } else {
        [[%c(SBAirplaneModeController) sharedInstance] setInAirplaneMode:YES];
    }
}

void toggleReachabilityMode() {
	[[%c(SBReachabilityManager) sharedInstance] _toggleReachabilityMode];
}

void toggleFlashlight() {
	static AVFlashlight *flashlight = [[%c(AVFlashlight) alloc] init];

    if (flashlightEnabled) {
        [flashlight setFlashlightLevel:0 withError:nil];
        flashlightEnabled = NO;
    } else {
        [flashlight setFlashlightLevel:1 withError:nil];
        flashlightEnabled = YES;
    }

}

void playPause() {
	MRMediaRemoteSendCommand(kMRTogglePlayPause, 0);
}

void toggleOrientationLock() {
    if ([[%c(SBOrientationLockManager) sharedInstance] isUserLocked]) {
        [[%c(SBOrientationLockManager) sharedInstance] unlock];
    } else {
        [[%c(SBOrientationLockManager) sharedInstance] lock];
    }
}

void toggleLPM() {
	if ([[NSProcessInfo processInfo] isLowPowerModeEnabled]) {
		[[%c(_CDBatterySaver) sharedInstance] setPowerMode:0 error:nil];
	} else {
		[[%c(_CDBatterySaver) sharedInstance] setPowerMode:1 error:nil];
	}
}

void toggleDarkMode() {
	if (@available(iOS 13, *)) {
		UISUserInterfaceStyleMode *styleMode = [[%c(UISUserInterfaceStyleMode) alloc] init];
		if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
			styleMode.modeValue = 1;
		} else {
			styleMode.modeValue = 2;
		}
	}
}

void toggleDND() {
  if(DNDEnabled == false){
    if (!assertionService) {
      assertionService = (DNDModeAssertionService *)[objc_getClass("DNDModeAssertionService") serviceForClientIdentifier:@"com.apple.donotdisturb.control-center.module"];
    }
    DNDModeAssertionDetails *newAssertion = [objc_getClass("DNDModeAssertionDetails") userRequestedAssertionDetailsWithIdentifier:@"com.apple.control-center.manual-toggle" modeIdentifier:@"com.apple.donotdisturb.mode.default" lifetime:nil];
    [assertionService takeModeAssertionWithDetails:newAssertion error:NULL];

  } else if(DNDEnabled == true){
	if (!assertionService) {
    	assertionService = (DNDModeAssertionService *)[objc_getClass("DNDModeAssertionService") serviceForClientIdentifier:@"com.apple.donotdisturb.control-center.module"];
    }
      [assertionService invalidateAllActiveModeAssertionsWithError:NULL];
    }
}

%hook DNDState
-(BOOL)isActive {
	// Fetch current dnd state
	DNDEnabled = %orig;
	return DNDEnabled;
}
%end

// Fix this
/* void toggleNightShift() {
	Status status;
	CBBlueLightClient *nightShift = [[%c(CBBlueLightClient) alloc] init];
	[nightShift getBlueLightStatus:&status];
	BOOL shiftEnabled = status.enabled;
	if (shiftEnabled) {
		[nightShift setEnabled:NO];
	} else if (!shiftEnabled)  {
		[nightShift setEnabled:YES];
	}
} */

void toggleCC() {
	if ([[%c(SBControlCenterController) sharedInstance] isVisible]) {
		[[%c(SBControlCenterController) sharedInstance] dismissAnimated:YES];
	} else {
		[[%c(SBControlCenterController) sharedInstance] presentAnimated:YES];
	}
}

void toggleSwitcher() {
	SBHomeHardwareButtonActions *show = [[%c(SBHomeHardwareButtonActions) alloc] init];
	[show performDoublePressDownActions];
}

// void openCamera() {
// 	[[%c(UIApplication) sharedApplication] launchApplicationWithIdentifier:@"com.apple.camera" suspended:NO];
// }

// void openSpotify() {
// 	[[%c(UIApplication) sharedApplication] launchApplicationWithIdentifier:@"com.spotify.client" suspended:NO];
// }

/* =-=-=-=-=-= End Toggle Functions =-=-=-=-=-= */


%hook SBRingerControl

-(void)activateRingerHUDFromMuteSwitch:(int)arg1 {


	if ([preferences boolForKey:@"enabled"] && ![preferences boolForKey:@"openApp"]) {
		switch ([preferences integerForKey:@"actionsList"]) {
			case 0:
				toggleReachabilityMode();
				break;
			case 1:
				toggleAirplaneMode();
				break;
			case 2:
				toggleFlashlight();
				break;
			case 3:
				playPause();
				break;
			case 4:
				toggleOrientationLock();
				break;
			case 5:
				toggleLPM();
				break;
			case 6:
				toggleDarkMode();
				break;
			case 7:
				toggleDND();
				break;
			case 8:
				toggleCC();
				break;
			case 9:
				toggleSwitcher();
				break;
			// case 10:
			// 	openCamera();
			// 	break;
			// case 11:
			// 	openSpotify();
			// 	break;
			default:
				break;
		}
	} // enabled switch

	if ([preferences boolForKey:@"enabled"] && [preferences boolForKey:@"openApp"]) {

		NSArray *apps = [%c(SparkAppList) getAppListForIdentifier:@"com.chr1s.ringeractionsprefs" andKey:@"apps"];
		for (NSString *appid in apps) {
			[[%c(UIApplication) sharedApplication] launchApplicationWithIdentifier:appid suspended:NO];
		}

	}

	// Disable ringer HUD when toggling the switch
	if ([preferences boolForKey:@"enabled"] && [preferences boolForKey:@"hideHUD"]) return;
	%orig;
}

%end

%ctor {

    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.chr1s.ringeractionsprefs"];
    [preferences registerDefaults:@{
        @"enabled": @YES,
		@"hideHUD": @YES
    }];

}