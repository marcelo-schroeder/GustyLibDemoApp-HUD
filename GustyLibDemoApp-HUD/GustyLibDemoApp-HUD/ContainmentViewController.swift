//
//  ContainmentViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 29/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class ContainmentViewController: UIViewController {

    var shouldTargetSubview = false
    
    //MARK: Overrides
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if (!self.shouldTargetSubview) {
            
            let childViewController = self.childViewControllers[0] as ContainmentChildViewController
            
            let hudViewController = IFAHudViewController()
            hudViewController.text = "In parent VC"
            hudViewController.presentHudViewControllerWithParentViewController(childViewController, parentView: nil, animated: false, completion: nil)
            
            childViewController.hudContainerView.hidden = true
            
        }

    }
    
}