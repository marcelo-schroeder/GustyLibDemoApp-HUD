//
//  MenuViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 19/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import UIKit

private enum TableViewRow: Int {
    case Text
    case DetailText
    case VisualIndicatorIndeterminateProgress
    case VisualIndicatorDeterminateProgress
    case VisualIndicatorSuccess
    case VisualIndicatorError
    case VisualIndicatorCustomView
    case ChromeTapWithAutoDismissal
    case ChromeTapWithAction
    case OverlayTapWithAutoDismissal
    case OverlayTapWithAction
    case LayoutCompressed
    case LayoutExpanded
    case LayoutPadding
    case LayoutInteritemSpacing
    case DynamicLayoutWithoutAnimation
    case DynamicLayoutWithAnimation
    case FontTextStyleCustomisation
    case FontCustomisation
    case PlainStyleOldSchool
    case PlainStyleCustomColours
    case BlurStyleDark
    case BlurStyleLight
    case BlurAndVibrancyStyleDark
    case BlurAndVibrancyStyleLight
    case ContainmentDedicatedWindow
    case ContainmentParentViewController
    case ContainmentParentViewControllerSubview
    case ContainmentMultipleHuds
    case OrderDefault
    case OrderCustomised
    case AnimationWith
    case AnimationWithout
    case AnimationCustomisedDuration
    case CompletionPresentation
    case CompletionDismissal
}

class MenuViewController: UITableViewController {

    enum DynamicLayoutTextType: Int {
        case Short
        case Medium
        case Long
        case End
    }

    var hudViewController: IFAHudViewController!
    var contentSizeCategoryChangeObserver: NSObjectProtocol?

    //MARK: UITableViewControllerDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let tableViewRow = indexPath.tableViewRow()

        switch tableViewRow {
        case .BlurStyleDark:
            fallthrough
        case .BlurStyleLight:
            fallthrough
        case .BlurAndVibrancyStyleDark:
            fallthrough
        case .BlurAndVibrancyStyleLight:
            fallthrough
        case .ContainmentParentViewController:
            fallthrough
        case .ContainmentParentViewControllerSubview:
            fallthrough
        case .ContainmentMultipleHuds:
            return  // handled as segue
        default:
            self.handleNonSegueCase(forSelectedTableViewRow: tableViewRow)
        }

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        super.prepareForSegue(segue, sender: sender)
        
        let selectedRowIndexPath = self.tableView.indexPathForSelectedRow()!

        if (segue.destinationViewController is BlurAndVibrancyStyleViewController) {
            
            let viewController = segue.destinationViewController as BlurAndVibrancyStyleViewController

            switch selectedRowIndexPath.tableViewRow() {
            case .BlurStyleDark:
                viewController.text = "Blur style - dark"
                viewController.style = IFAHudViewStyle.Blur
                viewController.imageName = "windsurf"
                viewController.chromeForegroundColour = UIColor.whiteColor()
                viewController.blurEffectStyle = UIBlurEffectStyle.Dark
            case .BlurStyleLight:
                viewController.text = "Blur style - light"
                viewController.style = IFAHudViewStyle.Blur
                viewController.imageName = "planet"
                viewController.chromeForegroundColour = UIColor.blackColor()
                viewController.blurEffectStyle = UIBlurEffectStyle.Light
            case .BlurAndVibrancyStyleDark:
                viewController.text = "Blur and vibrancy style - dark"
                viewController.style = IFAHudViewStyle.BlurAndVibrancy
                viewController.imageName = "windsurf"
                viewController.blurEffectStyle = UIBlurEffectStyle.Dark
            case .BlurAndVibrancyStyleLight:
                viewController.text = "Blur and vibrancy style - light"
                viewController.style = IFAHudViewStyle.BlurAndVibrancy
                viewController.imageName = "planet"
                viewController.blurEffectStyle = UIBlurEffectStyle.Light
            default:
                assert(false, "Unexpected selected row")
            }
            
            // Image credits
            switch selectedRowIndexPath.tableViewRow() {
            case .BlurStyleDark:
                fallthrough
            case .BlurAndVibrancyStyleDark:
                viewController.imageTitle = "Windsurf surf"
                viewController.imageAuthor = "Kanaka Menehune"
                viewController.imageUrl = "https://flic.kr/p/5eYAzL"
            case .BlurStyleLight:
                fallthrough
            case .BlurAndVibrancyStyleLight:
                viewController.imageTitle = "* Planet *"
                viewController.imageAuthor = "Parée"
                viewController.imageUrl = "https://flic.kr/p/5WBkp9"
            default:
                assert(false, "Unexpected selected row")
            }
            
        } else if (segue.destinationViewController is ContainmentViewController) {
            
            let viewController = segue.destinationViewController as ContainmentViewController

            switch selectedRowIndexPath.tableViewRow() {
            case .ContainmentParentViewController:
                viewController.shouldTargetSubview = false
            case .ContainmentParentViewControllerSubview:
                viewController.shouldTargetSubview = true
            default:
                assert(false, "Unexpected selected row")
            }
            
        }

    }

    //MARK: Private

    private func handleNonSegueCase(forSelectedTableViewRow tableViewRow: TableViewRow) {

        // Initialise HUD
        self.hudViewController = IFAHudViewController()
        let hudView = self.hudViewController.hudView

        // Appearance
        switch tableViewRow {
        case .LayoutExpanded:
            hudView.chromeViewLayoutFittingSize = UILayoutFittingExpandedSize
        case .LayoutPadding:
            hudView.chromeHorizontalPadding = 30
            hudView.chromeVerticalPadding = 20
        case .LayoutInteritemSpacing:
            hudView.chromeVerticalInteritemSpacing = 30
        case .DynamicLayoutWithAnimation:
            hudView.shouldAnimateLayoutChanges = true
        case .FontTextStyleCustomisation:
            hudView.textLabelFontTextStyle = UIFontTextStyleBody
            hudView.detailTextLabelFontTextStyle = UIFontTextStyleFootnote
        case .FontCustomisation:
            hudView.textLabelFont = UIFont(name: "Chalkduster", size: 20)
            hudView.detailTextLabelFont = UIFont(name: "ChalkboardSE-Light", size: 14)
        case .PlainStyleOldSchool:
            hudView.style = IFAHudViewStyle.Plain
            hudView.chromeBackgroundColour = UIColor.blackColor().colorWithAlphaComponent(0.75)
        case .PlainStyleCustomColours:
            hudView.style = IFAHudViewStyle.Plain
            hudView.overlayColour = UIColor.blueColor().colorWithAlphaComponent(0.2)
            hudView.chromeForegroundColour = UIColor.yellowColor()
            hudView.chromeBackgroundColour = UIColor.redColor().colorWithAlphaComponent(0.75)
        default:
            break   // does nothing
        }

        // Text
        var text: String?
        switch tableViewRow {
        case .Text:
            fallthrough
        case .DetailText:
            text = "Text label"
        case .VisualIndicatorIndeterminateProgress:
            text = "Indeterminate progress"
        case .VisualIndicatorDeterminateProgress:
            text = "Determinate progress"
        case .VisualIndicatorSuccess:
            text = "Success"
        case .VisualIndicatorError:
            text = "Error"
        case .VisualIndicatorCustomView:
            text = "Custom view"
        case .ChromeTapWithAutoDismissal:
            text = "Tap inside to auto dismiss"
        case .ChromeTapWithAction:
            text = "Tap inside to dismiss with action"
        case .OverlayTapWithAutoDismissal:
            text = "Tap outside to auto dismiss"
        case .OverlayTapWithAction:
            text = "Tap outside to dismiss with action"
        case .LayoutCompressed:
            text = "Compressed"
        case .LayoutExpanded:
            text = "Expanded"
        case .LayoutPadding:
            text = "Padding"
        case .LayoutInteritemSpacing:
            text = "Inter-item spacing"
        case .FontTextStyleCustomisation:
            text = "Text style customisation"
        case .FontCustomisation:
            text = "Font customisation"
        case .PlainStyleOldSchool:
            text = "Plain - old school"
        case .PlainStyleCustomColours:
            text = "Plain - custom colours"
        case .DynamicLayoutWithoutAnimation:
            fallthrough
        case .DynamicLayoutWithAnimation:
            text = dynamicLayoutText(fromType: DynamicLayoutTextType.Short)
        case .ContainmentDedicatedWindow:
            text = "Shown in its own window"
        case .OrderDefault:
            text = "Text label at the top"
        case .OrderCustomised:
            text = "Text label is second"
        case .AnimationWith:
            text = "With animation"
        case .AnimationWithout:
            text = "Without animation"
        case .AnimationCustomisedDuration:
            text = "Customised animation duration"
        case .CompletionPresentation:
            text = "Presentation completion block"
        case .CompletionDismissal:
            text = "Dismissal completion block"
        default:
            text = nil
        }

        // Detail text
        var detailText: String?;
        switch tableViewRow {
        case .DetailText:
            fallthrough
        case .FontTextStyleCustomisation:
            fallthrough
        case .LayoutPadding:
            fallthrough
        case .LayoutInteritemSpacing:
            fallthrough
        case .FontCustomisation:
            detailText = "Detail text label"
        case .OrderDefault:
            detailText = "Detail text label at the bottom"
        case .OrderCustomised:
            detailText = "Detail text label at the top"
        default:
            detailText = nil
        }

        // Visual indicator mode
        var customVisualIndicatorView: UIView?
        var visualIndicatorMode: IFAHudViewVisualIndicatorMode
        switch tableViewRow {
        case .VisualIndicatorDeterminateProgress:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.ProgressDeterminate
        case .VisualIndicatorSuccess:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.Success
        case .VisualIndicatorError:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.Error
        case .VisualIndicatorCustomView:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.Custom
            let image = UIImage(named: "hand-like")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate) // Rendering mode is set to template so that the chrome's foreground colour is automatically used
            customVisualIndicatorView = UIImageView(image: image)
        case .VisualIndicatorIndeterminateProgress:
            fallthrough
        case .OrderDefault:
            fallthrough
        case .OrderCustomised:
            fallthrough
        case .ChromeTapWithAutoDismissal:
            fallthrough
        case .ChromeTapWithAction:
            fallthrough
        case .OverlayTapWithAutoDismissal:
            fallthrough
        case .LayoutPadding:
            fallthrough
        case .LayoutInteritemSpacing:
            fallthrough
        case .OverlayTapWithAction:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.ProgressIndeterminate
        default:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.None
        }

        // Auto dismissal delay
        var autoDismissalDelay: NSTimeInterval
        switch tableViewRow {
        case .VisualIndicatorDeterminateProgress:
            fallthrough
        case .ChromeTapWithAutoDismissal:
            fallthrough
        case .ChromeTapWithAction:
            fallthrough
        case .OverlayTapWithAutoDismissal:
            fallthrough
        case .OverlayTapWithAction:
            fallthrough
        case .DynamicLayoutWithoutAnimation:
            fallthrough
        case .DynamicLayoutWithAnimation:
            fallthrough
        case .CompletionDismissal:
            autoDismissalDelay = 0.0
        case .OrderDefault:
            fallthrough
        case .OrderCustomised:
            fallthrough
        case .LayoutPadding:
            fallthrough
        case .LayoutInteritemSpacing:
            fallthrough
        case .ContainmentDedicatedWindow:
            fallthrough
        case .VisualIndicatorIndeterminateProgress:
            autoDismissalDelay = 2.0
        default:
            autoDismissalDelay = 0.5
        }

        // Chrome tap action block
        var chromeTapActionBlock: (() -> Void)?
        switch tableViewRow {
        case .ChromeTapWithAction:
            chromeTapActionBlock = {
                [unowned self] in
                self.hudViewController.dismissHudViewControllerWithAnimated(true, completion: nil)
            }
        default:
            chromeTapActionBlock = nil
        }

        // Should dismiss on chrome tap?
        var shouldDismissOnChromeTap: Bool
        switch tableViewRow {
        case .ChromeTapWithAutoDismissal:
            shouldDismissOnChromeTap = true
        default:
            shouldDismissOnChromeTap = false
        }

        // Overlay tap action block
        var overlayTapActionBlock: (() -> Void)?
        switch tableViewRow {
        case .OverlayTapWithAction:
            overlayTapActionBlock = {
                [unowned self] in
                self.hudViewController.dismissHudViewControllerWithAnimated(true, completion: nil)
            }
        default:
            overlayTapActionBlock = nil
        }

        // Should dismiss on overlay tap?
        var shouldDismissOnOverlayTap: Bool
        switch tableViewRow {
        case .OverlayTapWithAutoDismissal:
            shouldDismissOnOverlayTap = true
        default:
            shouldDismissOnOverlayTap = false
        }
        
        // Configure HUD
        self.hudViewController.text = text
        self.hudViewController.detailText = detailText
        self.hudViewController.chromeTapActionBlock = chromeTapActionBlock
        self.hudViewController.shouldDismissOnChromeTap = shouldDismissOnChromeTap
        self.hudViewController.overlayTapActionBlock = overlayTapActionBlock
        self.hudViewController.shouldDismissOnOverlayTap = shouldDismissOnOverlayTap
        self.hudViewController.autoDismissalDelay = autoDismissalDelay
        self.hudViewController.customVisualIndicatorView = customVisualIndicatorView
        self.hudViewController.visualIndicatorMode = visualIndicatorMode

        // Content subview order
        switch tableViewRow {
        case .OrderCustomised:
            hudView.contentSubviewVerticalOrder.removeAllObjects()
            hudView.contentSubviewVerticalOrder.addObject(IFAHudContentSubviewId.DetailTextLabel.rawValue)
            hudView.contentSubviewVerticalOrder.addObject(IFAHudContentSubviewId.TextLabel.rawValue)
            hudView.contentSubviewVerticalOrder.addObject(IFAHudContentSubviewId.ActivityIndicatorView.rawValue)
        default:
            break
        }
        
        // Animation
        var shouldAnimate: Bool
        switch tableViewRow {
        case .AnimationWithout:
            shouldAnimate = false
        case .AnimationCustomisedDuration:
            self.hudViewController.presentationAnimationDuration = 2
            self.hudViewController.dismissalAnimationDuration = 3
            fallthrough
        case .AnimationWith:
            fallthrough
        default:
            shouldAnimate = true
        }

        // Presentation completion closure
        var presentationCompletion: ((a_finished: Bool) -> Void)?
        switch tableViewRow {
        case .VisualIndicatorDeterminateProgress:
            presentationCompletion = { [unowned self] (a_finished: Bool) -> Void in
                self.determinateProgressCompletion(hudViewController: self.hudViewController)
            }
        case .DynamicLayoutWithoutAnimation:
            fallthrough
        case .DynamicLayoutWithAnimation:
            presentationCompletion = { [unowned self] (a_finished: Bool) -> Void in
                self.dynamicLayoutCompletion(hudViewController: self.hudViewController, textType: DynamicLayoutTextType(rawValue: DynamicLayoutTextType.Short.rawValue + 1)!)
            }
        case .CompletionPresentation:
            presentationCompletion = { [unowned self] (a_finished: Bool) -> Void in
                self.ifa_presentAlertControllerWithTitle(nil, message: "Alert shown by presentation completion block")
            }
        case .CompletionDismissal:
            let dismissalCompletion = { (a_finished: Bool) -> Void in
                self.ifa_presentAlertControllerWithTitle(nil, message: "Alert shown by dismissal completion block")
            }
            presentationCompletion = { [unowned self] (a_finished: Bool) -> Void in
                self.hudViewController.dismissHudViewControllerWithAnimated(true, completion: dismissalCompletion)
            }
        default:
            presentationCompletion = nil
        }

        // Present HUD in its own dedicated window
        self.hudViewController.presentHudViewControllerWithParentViewController(nil, parentView: nil, animated: shouldAnimate, completion: presentationCompletion)

    }

    private func determinateProgressCompletion(hudViewController a_hudViewController: IFAHudViewController) {
        IFAUtils.dispatchAsyncMainThreadBlock(
        {
            if a_hudViewController.progress == 1.0 {
                self.hudViewController.dismissHudViewControllerWithAnimated(true, completion: nil)
            } else {
                a_hudViewController.progress += 0.25
                self.determinateProgressCompletion(hudViewController: a_hudViewController)
            }
        }
                , afterDelay: 1)
    }

    private func dynamicLayoutCompletion(hudViewController a_hudViewController: IFAHudViewController, textType a_textType: DynamicLayoutTextType) {
        IFAUtils.dispatchAsyncMainThreadBlock(
        {
            if a_textType == .End {
                self.hudViewController.dismissHudViewControllerWithAnimated(true, completion: nil)
            } else {
                a_hudViewController.text = self.dynamicLayoutText(fromType: a_textType)
                self.dynamicLayoutCompletion(hudViewController: a_hudViewController, textType: DynamicLayoutTextType(rawValue: a_textType.rawValue + 1)!)
            }
        }
                , afterDelay: 1)
    }

    private func dynamicLayoutText(fromType a_textType: DynamicLayoutTextType) -> String {
        var textType: String?
        switch a_textType {
        case .Short:
            textType = "Short"
        case .Medium:
            textType = "Short followed by Medium"
        case .Long:
            textType = "Short followed by Medium then followed by Long"
        default:
            assert(false, "Unexpected text type")
        }
        return textType!;
    }

}

private extension NSIndexPath {
    
    func tableViewRow() -> TableViewRow {
        switch (self.section, self.row) {
        case (0, 0):
            return TableViewRow.Text
        case (0, 1):
            return TableViewRow.DetailText
        case (1, 0):
            return TableViewRow.VisualIndicatorIndeterminateProgress
        case (1, 1):
            return TableViewRow.VisualIndicatorDeterminateProgress
        case (1, 2):
            return TableViewRow.VisualIndicatorSuccess
        case (1, 3):
            return TableViewRow.VisualIndicatorError
        case (1, 4):
            return TableViewRow.VisualIndicatorCustomView
        case (2, 0):
            return TableViewRow.ChromeTapWithAutoDismissal
        case (2, 1):
            return TableViewRow.ChromeTapWithAction
        case (2, 2):
            return TableViewRow.OverlayTapWithAutoDismissal
        case (2, 3):
            return TableViewRow.OverlayTapWithAction
        case (3, 0):
            return TableViewRow.LayoutCompressed
        case (3, 1):
            return TableViewRow.LayoutExpanded
        case (3, 2):
            return TableViewRow.LayoutPadding
        case (3, 3):
            return TableViewRow.LayoutInteritemSpacing
        case (4, 0):
            return TableViewRow.DynamicLayoutWithoutAnimation
        case (4, 1):
            return TableViewRow.DynamicLayoutWithAnimation
        case (5, 0):
            return TableViewRow.FontTextStyleCustomisation
        case (5, 1):
            return TableViewRow.FontCustomisation
        case (6, 0):
            return TableViewRow.PlainStyleOldSchool
        case (6, 1):
            return TableViewRow.PlainStyleCustomColours
        case (6, 2):
            return TableViewRow.BlurStyleDark
        case (6, 3):
            return TableViewRow.BlurStyleLight
        case (6, 4):
            return TableViewRow.BlurAndVibrancyStyleDark
        case (6, 5):
            return TableViewRow.BlurAndVibrancyStyleLight
        case (7, 0):
            return TableViewRow.ContainmentDedicatedWindow
        case (7, 1):
            return TableViewRow.ContainmentParentViewController
        case (7, 2):
            return TableViewRow.ContainmentParentViewControllerSubview
        case (7, 3):
            return TableViewRow.ContainmentMultipleHuds
        case (8, 0):
            return TableViewRow.OrderDefault
        case (8, 1):
            return TableViewRow.OrderCustomised
        case (9, 0):
            return TableViewRow.AnimationWith
        case (9, 1):
            return TableViewRow.AnimationWithout
        case (9, 2):
            return TableViewRow.AnimationCustomisedDuration
        case (10, 0):
            return TableViewRow.CompletionPresentation
        case (10, 1):
            return TableViewRow.CompletionDismissal
        default:
            assert(false, "Unexpected section and row")
            return TableViewRow.Text
        }
    }
   
}

