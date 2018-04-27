//
//  AppDelegate.m
//  video360
//
//  Copyright © 2018 SpherePlay. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//////////
// Init //
////////////////////////////////////////////////////////////////////////////////

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupPlayer];
    [self setupGestures];
    
    return YES;
}

////////////
// Player //
////////////////////////////////////////////////////////////////////////////////

-(void)setupPlayer{
    
    //NOTE: It's mandatory to disable bitcode to support GVR libs
    
    //Verify VrPlayerLib license
    NSString *sphereplayCustomerId = @"REPLACE_WITH_MY_ACCOUNT_ID_FROM_SPHEREPLAY_CONSOLE";
    NSString *sphereplayLicenceKey = @"REPLACE_WITH_MY_KEY_FROM_SPHEREPLAY_CONSOLE";
    [VrPlayerViewController registerLicenseKey:sphereplayLicenceKey forCustomerId:sphereplayCustomerId];
    
    //Create instance of VR Player view-controller
    _vrPlayerViewController = [[VrPlayerViewController alloc] init];
    self.window.rootViewController = _vrPlayerViewController;
    
    //Load config
    VrPlayerConfig *config = [[VrPlayerConfig alloc] init];
    config.bgColor = @"#ff5010";
    config.projectionTypeOverride = PROJECTION_SPHERE;
    config.stereoFormatTypeOverride = FORMAT_MONO;
    config.showVirtualMenu = false;
    [_vrPlayerViewController loadConfig:config];
    
    //Load media
    VrPlayerMedia *media = [[VrPlayerMedia alloc] initWithUrl:[NSURL URLWithString:@"http://d1s3yn3kxq96sy.cloudfront.net/bigbuckbunny/index.m3u8"]];
    [_vrPlayerViewController loadMedia:media];
    
    //Delegates
    [_vrPlayerViewController addVrPlayerDelegate:self];
    
}

//////////////
// Gestures //
////////////////////////////////////////////////////////////////////////////////

-(void)setupGestures{
    
    self.window.rootViewController.view.userInteractionEnabled = YES;
    self.window.rootViewController.view.multipleTouchEnabled = YES;
    
    //UIGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 0.5 ;
    longPress.numberOfTouchesRequired = 1 ;
    longPress.delaysTouchesBegan = NO;
    longPress.delaysTouchesEnded = NO;
    //[longPress requireGestureRecognizerToFail:pinchGesture];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTouchesRequired = 1;
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delaysTouchesBegan = NO;
    doubleTap.delaysTouchesEnded = NO;
    [doubleTap requireGestureRecognizerToFail:longPress];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.numberOfTouchesRequired = 1;
    singleTap.numberOfTapsRequired = 1;
    singleTap.delaysTouchesBegan = NO;
    singleTap.delaysTouchesEnded = NO;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    //[self.window.rootViewController.view addGestureRecognizer:pinchGesture];
    [self.window.rootViewController.view addGestureRecognizer:longPress];
    [self.window.rootViewController.view addGestureRecognizer:doubleTap];
    [self.window.rootViewController.view addGestureRecognizer:singleTap];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gesture{
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
    } else if (gesture.state == UIGestureRecognizerStateBegan) {
        [_vrPlayerViewController calibrate];
        //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gesture{
    VrPlayerConfig* currentConfig = [_vrPlayerViewController getConfig];
    currentConfig.vrMode = !currentConfig.vrMode;
    [_vrPlayerViewController loadConfig:currentConfig];
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)handleSingleTap:(UITapGestureRecognizer *)gesture{
    if([_vrPlayerViewController getIsPlaying]){
        [_vrPlayerViewController pause];
    }else{
        [_vrPlayerViewController play];
    }
}

//////////////////////
// VrPlayerDelegate //
////////////////////////////////////////////////////////////////////////////////

-(void)onConfigChanged{
    //NSLog(@"onConfigChanged");
}

-(void)onMediaChanged{
    //NSLog(@"onMediaChanged");
}
-(void)onIsPlayingChanged:(bool)isPlaying{
    //NSLog(@"onIsPlayingChanged");
}
-(void)onPositionChanged:(Float64)positionInSeconds{
    //NSLog(@"onPositionChanged");
}
-(void)onDurationChanged:(Float64)durationInSeconds{
    //NSLog(@"onDurationChanged");
}
-(void)onMediaLoaded{
    //NSLog(@"onMediaLoaded");
}
-(void)onMediaEnded{
    //NSLog(@"onMediaEnded");
}
-(void)onVirtualMenuCommandReceived:(NSString*)command parameters:(NSArray*)parameters{
    //NSLog(@"onVirtualMenuCommandReceived");
}
-(void)onVrModeChanged:(bool)vrMode{
    //NSLog(@"onVrModeChanged to %@", vrMode? @"true": @"false");
}

//////////////////
// App protocol //
////////////////////////////////////////////////////////////////////////////////

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
