//
//  MultipleHudsViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 23/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class MultipleHudsViewController: UIViewController {
    
    @IBOutlet weak var containerView1: UIView!

    var hudViewController: IFAHudViewController!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.hudViewController = IFAHudViewController(style: IFAHudViewStyle.Plain, chromeViewLayoutFittingMode: IFAHudViewChromeViewLayoutFittingMode.Compressed)
        self.hudViewController.text = "Test"
        self.presentViewController(self.hudViewController, animated: true, completion: nil) //wip: review
    }

}