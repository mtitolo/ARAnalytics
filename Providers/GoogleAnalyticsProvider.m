//
//  GoogleProvider.m
//  ARAnalyticsTests
//
//  Created by orta therox on 05/01/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.
//

#import "GoogleAnalyticsProvider.h"
#import "ARAnalyticsProviders.h"
#import "GAI.h"

@implementation GoogleAnalyticsProvider
#ifdef AR_GOOGLEANALYTICS_EXISTS

- (id)initWithIdentifier:(NSString *)identifier {
    NSAssert([GAI class], @"Google Analytics SDK is not included");
    [[GAI sharedInstance] trackerWithTrackingId:identifier];

    return [super init];
}

- (void)identifyUserWithID:(NSString *)userID andEmailAddress:(NSString *)email {
    // Not allowed in GA
    // https://developers.google.com/analytics/devguides/collection/ios/v2/customdimsmets#pii

    // The Google Analytics Terms of Service prohibit sending of any personally identifiable information (PII) to Google Analytics servers. For more information, please consult the Terms of Service.
}

- (void)setUserProperty:(NSString *)property toValue:(NSString *)value {
    [[[GAI sharedInstance] defaultTracker] set:property value:value];
}

- (void)event:(NSString *)event withProperties:(NSDictionary *)properties {
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:nil action:event label:nil value:nil] build]];
}

- (void)didShowNewPageView:(NSString *)pageTitle {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:pageTitle];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval {
    [self event:event withProperties:@{ @"length": interval }];
    
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createTimingWithCategory:nil interval:interval name:event label:nil] build]];
}

#endif
@end
