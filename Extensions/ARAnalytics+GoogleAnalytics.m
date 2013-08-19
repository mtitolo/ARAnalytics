//
//  ARAnalytics+GoogleAnalytics.m
//  ARAnalyticsTests
//
//  Created by orta therox on 16/03/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.
//

#import "ARAnalytics+GoogleAnalytics.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@implementation ARAnalytics (GoogleAnalytics)

+ (void)event:(NSString *)event withCategory:(NSString *)category withLabel:(NSString *)label withValue:(NSNumber *)value {
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:category action:event label:label value:value] build]];
}

+ (void)socialEvent:(NSString *)event onNetwork:(NSString *)network withAddress:(NSString *)address {
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createSocialWithNetwork:network action:event target:address] build]];
}

+ (void)sendUncaughtExceptionsToGoogleAnalytics {
    [GAI sharedInstance].trackUncaughtExceptions = YES;
}

@end
