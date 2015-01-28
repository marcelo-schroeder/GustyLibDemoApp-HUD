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
        
        let childViewController = self.childViewControllers[0] as ContainmentChildViewController

        let hudViewController = IFAHudViewController()
        hudViewController.text = "Hello1"
        hudViewController.presentHudViewControllerWithParentViewController(childViewController, parentView: nil, animated: false, completion: nil)

    }
    
    //wip: is this required?
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if (segue.destinationViewController is ContainmentChildViewController) {
//            
//            let viewController = segue.destinationViewController as ContainmentChildViewController
//            
//        }
//        
//    }
    
}