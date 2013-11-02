/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 
 Modified by Eric Horacek for Monospace Ltd. on 2/4/13
 */

#include <sys/sysctl.h>
#import "UIDevice-Hardware.h"

@interface UIDevice (Hardward)

- (NSString *)modelNameForModelIdentifier:(NSString *)modelIdentifier;

@end

@implementation UIDevice (Hardware)

- (NSString *)getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *)modelIdentifier
{
    return [self getSysInfoByName:"hw.machine"];
}

- (NSString *)modelName
{
    return [self modelNameForModelIdentifier:[self modelIdentifier]];
}

- (NSString *)modelNameForModelIdentifier:(NSString *)modelIdentifier
{
    // iPhone http://theiphonewiki.com/wiki/IPhone
    
    if ([modelIdentifier isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([modelIdentifier isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([modelIdentifier isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([modelIdentifier isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev A)";
    if ([modelIdentifier isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([modelIdentifier isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
    
    // iPad http://theiphonewiki.com/wiki/IPad
    
    if ([modelIdentifier isEqualToString:@"iPad1,1"])      return @"iPad 1G";
    if ([modelIdentifier isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPad2,4"])      return @"iPad 2 (Rev A)";
    if ([modelIdentifier isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,3"])      return @"iPad 3 (Gloabl)";
    if ([modelIdentifier isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad3,4"])      return @"iPad 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,4"])      return @"iPad 4 (Gloabl)";
    
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    
    if ([modelIdentifier isEqualToString:@"iPad2,5"])      return @"iPad mini 1G (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad2,6"])      return @"iPad mini 1G (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,7"])      return @"iPad mini 1G (Global)";
    
    // iPod http://theiphonewiki.com/wiki/IPod
    
    if ([modelIdentifier isEqualToString:@"iPod1,1"])      return @"iPod touch 1G";
    if ([modelIdentifier isEqualToString:@"iPod2,1"])      return @"iPod touch 2G";
    if ([modelIdentifier isEqualToString:@"iPod3,1"])      return @"iPod touch 3G";
    if ([modelIdentifier isEqualToString:@"iPod4,1"])      return @"iPod touch 4G";
    if ([modelIdentifier isEqualToString:@"iPod5,1"])      return @"iPod touch 5G";
    
    // Simulator
    if ([modelIdentifier hasSuffix:@"86"] || [modelIdentifier isEqual:@"x86_64"])
    {
        BOOL smallerScreen = ([[UIScreen mainScreen] bounds].size.width < 768.0);
        return (smallerScreen ? @"iPhone Simulator" : @"iPad Simulator");
    }
    
    return modelIdentifier;
}

- (UIDeviceFamily) deviceFamily
{
    NSString *modelIdentifier = [self modelIdentifier];
    if ([modelIdentifier hasPrefix:@"iPhone"]) return UIDeviceFamilyiPhone;
    if ([modelIdentifier hasPrefix:@"iPod"]) return UIDeviceFamilyiPod;
    if ([modelIdentifier hasPrefix:@"iPad"]) return UIDeviceFamilyiPad;
    return UIDeviceFamilyUnknown;
}

- (UIDeviceGenerationModel) deviceGenerationModel
{
    NSString *modelIdentifier = [self modelIdentifier];
    
    if ([modelIdentifier hasPrefix:@"iPhone1"])    return UIDeviceGenerationModeliPhone3G;
    if ([modelIdentifier hasPrefix:@"iPhone2"])    return UIDeviceGenerationModeliPhone3GS;
    if ([modelIdentifier hasPrefix:@"iPhone3"])    return UIDeviceGenerationModeliPhone4;
    if ([modelIdentifier hasPrefix:@"iPhone4"])    return UIDeviceGenerationModeliPhone4S;
    if ([modelIdentifier hasPrefix:@"iPhone5"])    return UIDeviceGenerationModeliPhone5;
    if ([modelIdentifier hasPrefix:@"iPhone6"])    return UIDeviceGenerationModeliPhone5S;
    
    // iPad http://theiphonewiki.com/wiki/IPad
    
    if ([modelIdentifier hasPrefix:@"iPad1,1"])      return UIDeviceGenerationModeliPad1;
    if ([modelIdentifier hasPrefix:@"iPad2,1"])      return UIDeviceGenerationModeliPad2;
    if ([modelIdentifier hasPrefix:@"iPad3,1"])      return UIDeviceGenerationModeliPad3;
    if ([modelIdentifier hasPrefix:@"iPad3,4"])      return UIDeviceGenerationModeliPad4;
    
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    
    if ([modelIdentifier hasPrefix:@"iPad2,5"])      return UIDeviceGenerationModeliPadMini1;
    if ([modelIdentifier hasPrefix:@"iPad2,6"])      return UIDeviceGenerationModeliPadMini1;
    if ([modelIdentifier hasPrefix:@"iPad2,7"])      return UIDeviceGenerationModeliPadMini1;
    
    // iPod http://theiphonewiki.com/wiki/IPod
    
    if ([modelIdentifier hasPrefix:@"iPod1"])      return UIDeviceGenerationModeliPod1;
    if ([modelIdentifier hasPrefix:@"iPod2"])      return UIDeviceGenerationModeliPod1;
    if ([modelIdentifier hasPrefix:@"iPod3"])      return UIDeviceGenerationModeliPod1;
    if ([modelIdentifier hasPrefix:@"iPod4"])      return UIDeviceGenerationModeliPod1;
    if ([modelIdentifier hasPrefix:@"iPod5"])      return UIDeviceGenerationModeliPod1;
    
    if ([modelIdentifier hasSuffix:@"86"] || [modelIdentifier isEqual:@"x86_64"])
    {
        BOOL smallerScreen = ([[UIScreen mainScreen] bounds].size.width < 768.0);
        return (smallerScreen ? UIDeviceGenerationModeliPhoneSimulator : UIDeviceGenerationModeliPadSimulator);
    }
    return UIDeviceGenerationModelUnknown;
}



@end
