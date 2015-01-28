//
//  ContainmentChildViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 29/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class ContainmentChildViewController: UIViewController {
    
    @IBOutlet weak var hudContainerView: UIView!
    
    //MARK: Overrides
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let hudViewController = IFAHudViewController()
        hudViewController.text = "Hello2"
        hudViewController.presentHudViewControllerWithParentViewController(self, parentView: hudContainerView, animated: false, completion: nil)
        
    }

}