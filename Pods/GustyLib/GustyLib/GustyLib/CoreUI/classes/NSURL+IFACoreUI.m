//
// Created by Marcelo Schroeder on 30/04/2014.
// Copyright (c) 2014 InfoAccent Pty Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "GustyLibCoreUI.h"


@implementation NSURL (IFACoreUI)

#pragma mark - Public

- (BOOL)ifa_isAppleUrlScheme {
    return [self.scheme isEqualToString:@"mailto"]
                || [self.scheme isEqualToString:@"tel"]
                || [self.scheme isEqualToString:@"facetime"]
                || [self.scheme isEqualToString:@"sms"];
}

-(void)ifa_open{
    [self ifa_openWithAlertPresenterViewController:nil];
}

-(void)ifa_openWithAlertPresenterViewController:(UIViewController *)a_alertPresenterViewController{
    void (^actionBlock)() = ^{
        [[UIApplication sharedApplication] openURL:self];
    };
    if (a_alertPresenterViewController) {
        NSString *title = [NSString stringWithFormat:@"You will now leave the %@ app", [IFAUtils appName]];
        [a_alertPresenterViewController ifa_presentAlertControllerWithTitle:title
                                                                    message:nil
                                                                      style:UIAlertControllerStyleAlert
                                                          actionButtonTitle:@"OK"
                                                                actionBlock:actionBlock];
    }else{
        actionBlock();
    }
}

@end