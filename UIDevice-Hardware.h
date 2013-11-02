/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 
 Modified by Eric Horacek for Monospace Ltd. on 2/4/13
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIDeviceFamily) {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
};

typedef enum {
    UIDeviceGenerationModeliPhone3G,
    UIDeviceGenerationModeliPhone3GS,
    UIDeviceGenerationModeliPhone4,
    UIDeviceGenerationModeliPhone4S,
    UIDeviceGenerationModeliPhone5,
    UIDeviceGenerationModeliPhone5S,
    UIDeviceGenerationModeliPhoneSimulator,
    UIDeviceGenerationModeliPad1,
    UIDeviceGenerationModeliPad2,
    UIDeviceGenerationModeliPad3,
    UIDeviceGenerationModeliPad4,
    UIDeviceGenerationModeliPadMini1,
    UIDeviceGenerationModeliPadSimulator,
    UIDeviceGenerationModeliPod1,
    UIDeviceGenerationModeliPod2,
    UIDeviceGenerationModeliPod3,
    UIDeviceGenerationModeliPod4,
    UIDeviceGenerationModeliPod5,
    UIDeviceGenerationModelUnknown
} UIDeviceGenerationModel;



@interface UIDevice (Hardware)

/**
 Returns a machine-readable model name in the format of "iPhone4,1"
 */
- (NSString *)modelIdentifier;

/**
 Returns a human-readable model name in the format of "iPhone 4S". Fallback of the the `modelIdentifier` value.
 */
- (NSString *)modelName;

/**
 Returns the device generation model as a `UIDeviceGenerationModel`
 */
- (UIDeviceGenerationModel) deviceGenerationModel;

/**
 Returns the device family as a `UIDeviceFamily`
 */
- (UIDeviceFamily)deviceFamily;

@end
