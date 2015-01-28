//
//  ImageCreditsViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 28/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class ImageCreditsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var imageTitle: String!
    var imageAuthor: String!
    var imageUrl: String!
    
    //MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = String(format: "'%@' by %@ available at %@ under a Creative Commons Attribution-NonCommercial 2.0 Generic licence. Full terms at https://creativecommons.org/licenses/by-nc/2.0/.", imageTitle, imageAuthor, imageUrl)
    }
    
}