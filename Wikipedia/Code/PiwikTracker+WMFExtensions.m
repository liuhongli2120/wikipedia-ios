#import "PiwikTracker+WMFExtensions.h"
#import "NSBundle+WMFInfoUtils.h"
@import NSDate_Extensions;

NS_ASSUME_NONNULL_BEGIN

@implementation NSString (WMFAnalytics)

- (NSString *)analyticsContext{
    return self;
}

- (NSString*)analyticsContentType{
    return self;
}

@end

@implementation PiwikTracker (WMFExtensions)

+ (void)wmf_start {
#ifdef PIWIK_ENABLED
    static NSTimeInterval const WMFDispatchInterval = 60;
    NSString *piwikHostURLString = @"https://piwik.wikimedia.org/";
    NSString *appID = @"3";
    [PiwikTracker sharedInstanceWithSiteID:appID baseURL:[NSURL URLWithString:piwikHostURLString]];
    [[PiwikTracker sharedInstance] setDispatchInterval:WMFDispatchInterval];
#endif
}

- (void)wmf_logView:(id<WMFAnalyticsViewNameProviding>)view {
    NSParameterAssert([view analyticsName]);
#ifdef PIWIK_ENABLED
    [self sendView:[view analyticsName]];
#endif
}

- (void)wmf_sendEventWithCategory:(NSString *)category action:(NSString *)action name:(NSString *)name value:(nullable NSNumber *)value {
#ifdef PIWIK_ENABLED
    [self sendEventWithCategory:category
                         action:action
                           name:name
                          value:value];
#endif
}

- (void)wmf_logActionPreviewInContext:(id<WMFAnalyticsContextProviding>)context
                          contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_logActionPreviewInContext:context contentType:contentType date:nil];
  }

- (void)wmf_logActionPreviewInContext:(id<WMFAnalyticsContextProviding>)context contentType:(id<WMFAnalyticsContentTypeProviding>)contentType date:(nullable NSDate*)date{
    
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Preview"
                               name:[contentType analyticsContentType]
                              value:nil];
}


- (void)wmf_logActionTapThroughInContext:(id<WMFAnalyticsContextProviding>)context
                             contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Tap Through"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionSaveInContext:(id<WMFAnalyticsContextProviding>)context
                       contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Save"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionUnsaveInContext:(id<WMFAnalyticsContextProviding>)context
                         contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Unsave"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionImpressionInContext:(id<WMFAnalyticsContextProviding>)context
                             contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Impression"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionTapThroughMoreInContext:(id<WMFAnalyticsContextProviding>)context
                                 contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Tap Through More"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionSwitchLanguageInContext:(id<WMFAnalyticsContextProviding>)context
                                 contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Switch Language"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionEnableInContext:(id<WMFAnalyticsContextProviding>)context
                                 contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Enable"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionDisableInContext:(id<WMFAnalyticsContextProviding>)context
                         contentType:(id<WMFAnalyticsContentTypeProviding>)contentType {
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Disable"
                               name:[contentType analyticsContentType]
                              value:nil];
}

- (void)wmf_logActionPushInContext:(id<WMFAnalyticsContextProviding>)context contentType:(id<WMFAnalyticsContentTypeProviding>)contentType date:(nullable NSDate*)date{
    [self wmf_sendEventWithCategory:[context analyticsContext]
                             action:@"Push"
                               name:[contentType analyticsContentType]
                              value:[self hourTimeValueFromDate:date]];
}


- (NSNumber*)hourTimeValueFromDate:(nullable NSDate*)date{
    return @([date hour]);
}


@end

NS_ASSUME_NONNULL_END
