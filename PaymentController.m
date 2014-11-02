//
//  PaymentController.m
//  Roam
//
//  Created by Jared Moskowitz on 11/2/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "PaymentController.h"

@implementation PaymentController

-(instancetype)init {
    self = [super init];
    if(self) {
        
    }
    
    return self;
}

-(void)initializeVenmo {
    [Venmo startWithAppId:@"2070" secret:@"GCT3JPRLw3PVAPeDswzzsy7xMZxxzwBr" name:@"Roam"];
}



-(void)pay:(NSString *)venmoId with:(CGFloat)amount {
    if (![Venmo isVenmoAppInstalled]) {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAPI];
    }
    else {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAppSwitch];
    }
    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments,
                                                 VENPermissionAccessProfile]
                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 NSLog(@"permissions requested");
                                 [[Venmo sharedInstance] sendPaymentTo:venmoId
                                                                amount:amount
                                                                  note:@"When in Roam!"
                                                     completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                                                         if (success) {
                                                             NSLog(@"Transaction succeeded!");
                                                         }
                                                         else {
                                                             NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                                                         }
                                                     }];
                             }
                             else {
                                 NSLog(@"failure");
                             }
                         }];
}



-(BOOL)handleURL:(NSURL *)url
{
    if ([[Venmo sharedInstance] handleOpenURL:url]) {
        return YES;
    }
    // You can add your app-specific url handling code here if needed
    return NO;
}

@end
