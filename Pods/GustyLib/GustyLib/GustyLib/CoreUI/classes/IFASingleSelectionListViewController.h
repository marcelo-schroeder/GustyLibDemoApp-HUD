//
//  IFASingleSelectionListViewController.h
//  Gusty
//
//  Created by Marcelo Schroeder on 28/07/10.
//  Copyright 2010 InfoAccent Pty Limited. All rights reserved.
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

@class NSManagedObject, IFASingleSelectionManager;
@protocol IFASelectionManagerDelegate;
@class IFASingleSelectionListViewControllerHeaderView;

@interface IFASingleSelectionListViewController : IFAAbstractSelectionListViewController <IFASelectionManagerDelegate>

@property (nonatomic, strong) UIImage *selectedIconImageNormal;
@property (nonatomic, strong) UIImage *selectedIconImageHighlighted;
@property(nonatomic) BOOL disallowDeselection;
@property (strong, nonatomic) IBOutlet IFASingleSelectionListViewControllerHeaderView *customHeaderView;

@end
