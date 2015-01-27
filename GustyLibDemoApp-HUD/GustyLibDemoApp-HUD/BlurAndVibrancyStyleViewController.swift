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
    
    //MARK: Overrides
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.destinationViewController is IFAHudViewController) {

            IFAHudView.appearance().style = self.style

            let viewController = segue.destinationViewController as IFAHudViewController
            viewController.text = self.text
            viewController.detailText = "Enjoy the view!"
            
        }
        
    }
    
}
