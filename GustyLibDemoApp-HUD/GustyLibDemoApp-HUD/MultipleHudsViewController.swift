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

    var hudManager: IFAHudManager!

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.hudManager = IFAHudManager(style: IFAHudViewStyle.Plain, chromeViewLayoutFittingMode: IFAHudChromeViewLayoutFittingMode.Compressed)
        self.hudManager.text = "Test"
        self.hudManager.presentWithCompletion(nil)
    }

}