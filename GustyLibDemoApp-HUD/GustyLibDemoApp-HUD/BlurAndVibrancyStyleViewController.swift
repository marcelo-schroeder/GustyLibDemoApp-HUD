//
// Created by Marcelo Schroeder on 21/01/15.
// Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class BlurAndVibrancyStyleViewController: UIViewController {
    
    var style:IFAHudViewStyle = IFAHudViewStyle.Blur
    var imageName:String = "light"
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        imageView.image = UIImage(named: imageName)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let hud: IFAHud = IFAHud(style: self.style, chromeViewLayoutFittingMode: IFAHudChromeViewLayoutFittingMode.Compressed)
        hud.text = self.title
        hud.detailText = "Photo credit: Marcelo Schroeder"
        hud.presentWithAutoDismissalDelay(2.0, completion: nil)
    }
    
}
