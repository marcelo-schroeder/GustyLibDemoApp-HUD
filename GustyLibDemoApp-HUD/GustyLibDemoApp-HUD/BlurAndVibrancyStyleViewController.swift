//
// Created by Marcelo Schroeder on 21/01/15.
// Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

//wip: clean up
class BlurAndVibrancyStyleViewController: UIViewController {
    
    var style:IFAHudViewStyle = IFAHudViewStyle.Blur
    var text:String?
    var imageName:String = "windsurf"

    var hudViewController: IFAHudViewController!

    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        imageView.image = UIImage(named: imageName)
    }

    //wip: fix the case where touches are now allowed wheren there is no animation
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.hudViewController = IFAHudViewController()
        self.hudViewController.style = self.style
        self.hudViewController.text = self.text
        self.hudViewController.detailText = "Enjoy the view!"
        self.hudViewController.presentationTransitionDuration = 3
//        self.hudManager.dismissalTransitionDuration = 0
//        self.hudManager.shouldAllowUserInteractionPassthrough = false
//        self.hudManager.overlayTapActionBlock = {
//            [unowned hudManager] in
//            self.hudManager.dismissWithPresentingViewController(self, animated: true, completion: nil)
//        }
//        self.hudManager.presentWithPresentingViewController(self, animated: false, autoDismissalDelay: 0, completion: nil)
//        self.hudManager.presentWithPresentingViewController(nil, animated: false, autoDismissalDelay: 0, completion: nil)
        self.presentViewController(self.hudViewController, animated: true, completion: nil) //wip: review
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        self.hudManager.dismissWithPresentingViewController(self, animated: false, completion: nil)
//        self.hudViewController.dismissWithPresentingViewController(nil, animated: false, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)   //wip: review
//        self.hudManager.dismissWithCompletion(nil)
    }
    
}
