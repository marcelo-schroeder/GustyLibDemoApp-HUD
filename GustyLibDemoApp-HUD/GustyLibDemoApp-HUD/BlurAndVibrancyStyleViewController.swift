//
// Created by Marcelo Schroeder on 21/01/15.
// Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class BlurAndVibrancyStyleViewController: UIViewController {
    
    var style:IFAHudViewStyle = IFAHudViewStyle.Blur
    var text:String?
    var imageName:String = "windsurf"

    var hudManager: IFAHudManager!

    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        imageView.image = UIImage(named: imageName)
    }

    //wip: fix the case where touches are now allowed wheren there is no animation
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.hudManager = IFAHudManager(style: self.style, chromeViewLayoutFittingMode: IFAHudChromeViewLayoutFittingMode.Compressed)
        self.hudManager.text = self.text
        self.hudManager.detailText = "Enjoy the view!"
        self.hudManager.presentationTransitionDuration = 3
//        self.hudManager.dismissalTransitionDuration = 0
//        self.hudManager.shouldAllowUserInteractionPassthrough = false
//        self.hudManager.overlayTapActionBlock = {
//            [unowned hudManager] in
//            self.hudManager.dismissWithPresentingViewController(self, animated: true, completion: nil)
//        }
//        self.hudManager.presentWithPresentingViewController(self, animated: false, autoDismissalDelay: 0, completion: nil)
//        self.hudManager.presentWithPresentingViewController(nil, animated: false, autoDismissalDelay: 0, completion: nil)
        self.hudManager.presentWithCompletion(nil)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        self.hudManager.dismissWithPresentingViewController(self, animated: false, completion: nil)
        self.hudManager.dismissWithPresentingViewController(nil, animated: false, completion: nil)
//        self.hudManager.dismissWithCompletion(nil)
    }
    
}
