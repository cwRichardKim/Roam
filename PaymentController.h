//
//  PaymentController.h
//  Roam
//
//  Created by Jared Moskowitz on 11/2/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Venmo-iOS-SDK/Venmo.h>

@interface PaymentController : NSObject

-(void)initializeVenmo;
-(void)pay:(NSString *)venmoId with:(float)amount;
-(BOOL)handleURL:(NSURL *)url;

@end
