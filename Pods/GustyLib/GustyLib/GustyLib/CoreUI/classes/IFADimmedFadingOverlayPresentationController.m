//
// Created by Marcelo Schroeder on 14/01/15.
// Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
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


@interface IFADimmedFadingOverlayPresentationController ()
@property(nonatomic, strong) UIView *IFA_overlayView;
@end

@implementation IFADimmedFadingOverlayPresentationController {

}


#pragma mark - Overrides

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController
                         presentingViewController:presentingViewController];
    if (self) {
        self.fadingOverlayPresentationControllerDataSource = self;
    }
    return self;
}

#pragma mark - IFAFadingOverlayPresentationControllerDataSource

- (UIView *)
overlayViewForFadingOverlayPresentationController:(IFAFadingOverlayPresentationController *)a_fadingOverlayPresentationController {
    return self.IFA_overlayView;
}

#pragma mark - Private

- (UIView *)IFA_overlayView {
    if (!_IFA_overlayView) {
        _IFA_overlayView = [UIView new];
        _IFA_overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _IFA_overlayView;
}

@end