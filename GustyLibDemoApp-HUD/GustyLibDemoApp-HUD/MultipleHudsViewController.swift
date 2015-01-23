//
//  MultipleHudsViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 23/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

//wip: memory profile
class MultipleHudsViewController: UIViewController {

    //MARK: Overrides
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if (segue.destinationViewController is IFAHudViewController) {

            let viewController = segue.destinationViewController as IFAHudViewController
            viewController.text = segue.identifier
            viewController.visualIndicatorMode = IFAHudViewVisualIndicatorMode.ProgressIndeterminate

        }
        
    }

}