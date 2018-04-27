//
//  AppDelegate.h
//  video360
//
//  Copyright © 2018 SpherePlay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <VrPlayerLib/VrPlayerLib.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, VrPlayerDelegate>{
    VrPlayerViewController* _vrPlayerViewController;
    bool _lastVrMode;
}

@property (strong, nonatomic) UIWindow *window;


@end

