//
// Created by Marcelo Schroeder on 21/01/15.
// Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class BlurAndVibrancyStyleViewController: UIViewController {
    
    var style:IFAHudViewStyle = IFAHudViewStyle.Blur
    var text:String?
    var imageName:String = "windsurf"

    var imageTitle: String!
    var imageAuthor: String!
    var imageUrl: String!

    var hudViewController: IFAHudViewController!

    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: imageName)
    }
    
    //MARK: Overrides
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.destinationViewController is IFAHudViewController) {

            IFAHudView.appearance().style = self.style

            let viewController = segue.destinationViewController as IFAHudViewController
            viewController.text = self.text
            viewController.detailText = "Enjoy the view!"
            
        } else if (segue.destinationViewController is ImageCreditsViewController) {

            let viewController = segue.destinationViewController as ImageCreditsViewController
            viewController.imageTitle = self.imageTitle
            viewController.imageAuthor = self.imageAuthor
            viewController.imageUrl = self.imageUrl
            
        }
        
    }
    
}
