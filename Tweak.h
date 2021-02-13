#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "MediaRemote.h"
#import <SparkAppList.h>

static BOOL flashlightEnabled = NO;
HBPreferences *preferences;

@interface SBReachabilityManager
+(id)sharedInstance;
-(void)_toggleReachabilityMode;
@end

@interface SBRingerControl
-(void)setRingerMuted:(BOOL)arg1;
@end

@protocol SBAirplaneModeDelegate;
@class RadiosPreferences;

@interface SBAirplaneModeController
@property (assign,getter=isInAirplaneMode,nonatomic) BOOL inAirplaneMode; 
+(id)sharedInstance;
-(BOOL)isInAirplaneMode;
-(void)setInAirplaneMode:(BOOL)arg1 ;
@end

@class AVFlashlightInternal;

@interface AVFlashlight : NSObject {

	AVFlashlightInternal* _internal;

}

@property (getter=isAvailable,nonatomic,readonly) BOOL available; 
@property (getter=isOverheated,nonatomic,readonly) BOOL overheated; 
@property (nonatomic,readonly) float flashlightLevel; 
+(BOOL)hasFlashlight;
+(void)initialize;
-(void)_handleNotification:(id)arg1 payload:(id)arg2 ;
-(float)flashlightLevel;
-(void)_setupFlashlight;
-(void)_teardownFlashlight;
-(BOOL)isOverheated;
-(void)_reconnectToServer;
-(BOOL)turnPowerOnWithError:(id*)arg1 ;
-(void)turnPowerOff;
-(BOOL)setFlashlightLevel:(float)arg1 withError:(id*)arg2 ;
-(BOOL)isAvailable;
-(id)init;
-(void)dealloc;
@end


// Orientation Lock
@interface SBOrientationLockManager
+(instancetype)sharedInstance;
-(BOOL)isUserLocked;
-(void)lock;
-(void)unlock;
@end

// Low Power Mode
@interface _CDBatterySaver
+(id)batterySaver;
-(BOOL)setPowerMode:(long long)arg1 error:(id *)arg2;
@end

// Dark Mode
@interface UISUserInterfaceStyleMode : NSObject
@property (nonatomic, assign) long long modeValue;
@end

//Do Not Disturb
@class DNDModeAssertionLifetime;

@interface DNDModeAssertionDetails : NSObject
+ (id)userRequestedAssertionDetailsWithIdentifier:(NSString *)identifier modeIdentifier:(NSString *)modeIdentifier lifetime:(DNDModeAssertionLifetime *)lifetime;
- (BOOL)invalidateAllActiveModeAssertionsWithError:(NSError **)error;
- (id)takeModeAssertionWithDetails:(DNDModeAssertionDetails *)assertionDetails error:(NSError **)error;
@end

@interface DNDModeAssertionService : NSObject
+ (id)serviceForClientIdentifier:(NSString *)clientIdentifier;
- (BOOL)invalidateAllActiveModeAssertionsWithError:(NSError **)error;
- (id)takeModeAssertionWithDetails:(DNDModeAssertionDetails *)assertionDetails error:(NSError **)error;
@end

static BOOL DNDEnabled;
static DNDModeAssertionService *assertionService;

typedef struct {
	BOOL active;
	BOOL enabled;
	BOOL sunSchedulePermitted;
	int mode;
	unsigned long long disableFlags;
	BOOL available;
} Status;

// Night Shift
@interface CBBlueLightClient : NSObject
- (BOOL)setActive:(BOOL)arg1;
- (BOOL)setEnabled:(BOOL)arg1;
- (BOOL)getBlueLightStatus:(Status *)arg1;
- (BOOL)isEnabled;
@end

@interface SBControlCenterController
-(BOOL)isVisible;
-(void)presentAnimated:(BOOL)arg1 ;
-(void)dismissAnimated:(BOOL)arg1 ;
@end

// Open App Switcher
@interface SBHomeHardwareButtonActions
-(void)performDoublePressDownActions;
@end

@interface SBSoundController
-(void)_ringerStateChanged:(id)arg1 ;
@end

@interface UIApplication (PrivateMethods)
- (BOOL)launchApplicationWithIdentifier:(NSString *)identifier suspended:(BOOL)suspend;
@end