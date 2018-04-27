VrPlayerLib SDK for iOS
=================================

VrPlayerLib for iOS let you display immersive media content embeded in an iOS app.

Getting started
----------------------------------------

### Requirements

* XCode
* iOS 8+
* [CocoaPod](https://cocoapods.org/#install)


### Install dependencies

First, you must include VrPlayerLib dependency in your CocoaPod *.Podfile*

```
pod 'VrPlayerLib', '~> 1.3'
```

Then, run the following CocoaPod command:

```
$ pod install
```

You can now use the generated *.xcworkspace* file to open your project in XCode.


### Register VrPlayerLib

In order to use the library, you need to create an account on the [SpherePlay console](http://console.sphereplay.com/register).

Once you have access to the console, head to the *Keys* section where you will find:

- Your *Account ID*
- Your product *Key* for VrPlayerLib iOS

These informations are required to register VrPlayerLib. All you have to do is call the following static method, only once, before any other library operation:

```
[VrPlayerViewController registerLicenseKey:@"MY_KEY" forCustomerId:@"MY_ACCOUNT_ID"];
```
**NOTE:** Don't forget to replace *MY_KEY* and *MY_ACCOUNT_ID* 

You are now ready to use the library and deliver your content!

Usage
----------------------------------------

### Player creation

Let's begin by creating and embeding an instance of the player:

```
VrPlayerViewController *vrPlayerViewController = [[VrPlayerViewController alloc] init];
self.window.rootViewController = vrPlayerViewController;
```

### Media configuration

The next step is to load our content using the VrPlayerMedia object:

```
VrPlayerMedia *media = [[VrPlayerMedia alloc] initWithUrl:[NSURL URLWithString:@"http://d1s3yn3kxq96sy.cloudfront.net/bigbuckbunny/index.m3u8"]];
[vrPlayerViewController loadMedia:media];
```

### Player configuration

You can optionally change settings and state of the player anytime. The config changes must be commited by loading them in the player.

```
VrPlayerConfig *config = [[VrPlayerConfig alloc] init];
config.bgColor = @"#ff5010";
config.projectionTypeOverride = PROJECTION_SPHERE;
config.stereoFormatTypeOverride = FORMAT_MONO;
[vrPlayerViewController loadConfig:config];
```

### Player control

When you are ready to playback the media, simply call the *play* method.

```
[vrPlayerViewController play];
```

Enjoy!


Infos
----------------------------------------

### Reference

For more details, including the complete list of methods and callbacks, see the [VrPlayerLib for iOS documentation](https://docs.sphereplay.com/vrplayerlib-ios/index.html).

### About

© VIMERSIV INC. 2018 - All Rights Reserved. SpherePlay is a registered trademark.