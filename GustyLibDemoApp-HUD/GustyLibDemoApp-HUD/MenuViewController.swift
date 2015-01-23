//
//  MenuViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 19/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import UIKit

//wip: add image credits
//wip: shorten the app's display name on the home screen

private enum TableViewRow: Int {
    case Text
    case DetailText
    case IndeterminateProgress
    case DeterminateProgress
    case Success
    case Error
    case ChromeTapWithAutoDismissal
    case ChromeTapWithAction
    case OverlayTapWithAutoDismissal
    case OverlayTapWithAction
    case Compressed
    case Expanded
    case CustomColours
    case DynamicLayoutWithoutAnimation
    case DynamicLayoutWithAnimation
    case BlurStyleDark
    case BlurStyleLight
    case BlurAndVibrancyStyleDark
    case BlurAndVibrancyStyleLight
    case MultipleHuds
}

class MenuViewController: UITableViewController {

    enum DynamicLayoutTextType: Int {
        case Short
        case Medium
        case Long
        case End
    }

    var hudViewController: IFAHudViewController!

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
        case .MultipleHuds:
            return
        default:
            self.handleNonSegueCase(forSelectedTableViewRow: tableViewRow)
        }

    }

    //MARK: Overrides

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.destinationViewController is BlurAndVibrancyStyleViewController) {
            
            let viewController = segue.destinationViewController as BlurAndVibrancyStyleViewController
            
            resetAppearance()
            
            let selectedRowIndexPath = self.tableView.indexPathForSelectedRow()!
            
            switch selectedRowIndexPath.tableViewRow() {
            case .BlurStyleDark:
                viewController.text = "Blur style - dark"
                viewController.style = IFAHudViewStyle.Blur
                viewController.imageName = "windsurf"
                IFAHudView.appearance().chromeForegroundColour = UIColor.whiteColor()
                IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Dark
            case .BlurStyleLight:
                viewController.text = "Blur style - light"
                viewController.style = IFAHudViewStyle.Blur
                viewController.imageName = "planet"
                IFAHudView.appearance().chromeForegroundColour = UIColor.blackColor()
                IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Light
            case .BlurAndVibrancyStyleDark:
                viewController.text = "Blur and vibrancy style - dark"
                viewController.style = IFAHudViewStyle.BlurAndVibrancy
                viewController.imageName = "windsurf"
                IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Dark
            case .BlurAndVibrancyStyleLight:
                viewController.text = "Blur and vibrancy style - light"
                viewController.style = IFAHudViewStyle.BlurAndVibrancy
                viewController.imageName = "planet"
                IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Light
            default:
                assert(false, "Unexpected selected row")
            }
            
        }

    }

    //MARK: Private

    private func handleNonSegueCase(forSelectedTableViewRow tableViewRow: TableViewRow) {

        // Initialise HUD
        self.hudViewController = IFAHudViewController()

        // Text
        var text: String?
        switch tableViewRow {
        case .Text:
            fallthrough
        case .DetailText:
            text = "Text label"
        case .IndeterminateProgress:
            text = "Indeterminate progress"
        case .DeterminateProgress:
            text = "Determinate progress"
        case .Success:
            text = "Success"
        case .Error:
            text = "Error"
        case .ChromeTapWithAutoDismissal:
            text = "Tap inside to auto dismiss"
        case .ChromeTapWithAction:
            text = "Tap inside to dismiss with action"
        case .OverlayTapWithAutoDismissal:
            text = "Tap outside to auto dismiss"
        case .OverlayTapWithAction:
            text = "Tap outside to dismiss with action"
        case .Compressed:
            text = "Compressed"
        case .Expanded:
            text = "Expanded"
        case .CustomColours:
            text = "Custom colours"
        case .DynamicLayoutWithoutAnimation:
            fallthrough
        case .DynamicLayoutWithAnimation:
            text = dynamicLayoutText(fromType: DynamicLayoutTextType.Short)
        default:
            text = nil
        }

        // Detail text
        var detailText: String?;
        switch tableViewRow {
        case .DetailText:
            detailText = "Detail text label"
        default:
            detailText = nil
        }

        // Visual indicator mode
        var visualIndicatorMode: IFAHudViewVisualIndicatorMode
        switch tableViewRow {
        case .IndeterminateProgress:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.ProgressIndeterminate
        case .DeterminateProgress:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.ProgressDeterminate
        case .Success:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.Success
        case .Error:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.Error
        case .ChromeTapWithAutoDismissal:
            fallthrough
        case .ChromeTapWithAction:
            fallthrough
        case .OverlayTapWithAutoDismissal:
            fallthrough
        case .OverlayTapWithAction:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.ProgressIndeterminate
        default:
            visualIndicatorMode = IFAHudViewVisualIndicatorMode.None
        }

        // Auto dismissal delay
        var autoDismissalDelay: NSTimeInterval
        switch tableViewRow {
        case .IndeterminateProgress:
            autoDismissalDelay = 2.0
        case .DeterminateProgress:
            autoDismissalDelay = 0.0
        case .ChromeTapWithAutoDismissal:
            fallthrough
        case .ChromeTapWithAction:
            fallthrough
        case .OverlayTapWithAutoDismissal:
            fallthrough
        case .OverlayTapWithAction:
            autoDismissalDelay = 0.0
        case .DynamicLayoutWithoutAnimation:
            fallthrough
        case .DynamicLayoutWithAnimation:
            autoDismissalDelay = 0.0
        default:
            autoDismissalDelay = 0.5
        }

        // Chrome tap action block
        var chromeTapActionBlock: (() -> Void)?
        switch tableViewRow {
        case .ChromeTapWithAction:
            chromeTapActionBlock = {
                [unowned self] in
                self.dismissViewControllerAnimated(true, completion: nil)   //wip: review
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
                self.dismissViewControllerAnimated(true, completion: nil)   //wip: review
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

        // Should animate layout changes?
        var shouldAnimateLayoutChanges: Bool
        switch tableViewRow {
        case .DynamicLayoutWithAnimation:
            shouldAnimateLayoutChanges = true
        default:
            shouldAnimateLayoutChanges = false
        }

        // Appearance
        switch tableViewRow {
        case .Expanded:
            resetAppearance()
            IFAHudView.appearance().chromeViewLayoutFittingSize = UILayoutFittingExpandedSize
        case .CustomColours:
            IFAHudView.appearance().overlayColour = UIColor.blueColor().colorWithAlphaComponent(0.2)
            IFAHudView.appearance().chromeForegroundColour = UIColor.yellowColor()
            IFAHudView.appearance().chromeBackgroundColour = UIColor.redColor().colorWithAlphaComponent(0.75)
        default:
            resetAppearance()
        }

        // Configure HUD
        self.hudViewController.text = text
        self.hudViewController.detailText = detailText
        self.hudViewController.visualIndicatorMode = visualIndicatorMode
        self.hudViewController.chromeTapActionBlock = chromeTapActionBlock
        self.hudViewController.shouldDismissOnChromeTap = shouldDismissOnChromeTap
        self.hudViewController.overlayTapActionBlock = overlayTapActionBlock
        self.hudViewController.shouldDismissOnOverlayTap = shouldDismissOnOverlayTap
        self.hudViewController.shouldAnimateLayoutChanges = shouldAnimateLayoutChanges
        self.hudViewController.autoDismissalDelay = autoDismissalDelay

        // Presentation completion closure
        var presentationCompletion: (() -> Void)?
        switch tableViewRow {
        case .DeterminateProgress:
            presentationCompletion = { [unowned self] in   //wip: review
                self.determinateProgressCompletion(hudViewController: self.hudViewController)
            }
        case .DynamicLayoutWithoutAnimation:
            fallthrough
        case .DynamicLayoutWithAnimation:
            presentationCompletion = { [unowned self] in   //wip: review
                self.dynamicLayoutCompletion(hudViewController: self.hudViewController, textType: DynamicLayoutTextType(rawValue: DynamicLayoutTextType.Short.rawValue + 1)!)
            }
        default:
            presentationCompletion = nil
        }

        // Present HUD
        self.presentViewController(self.hudViewController, animated: true, completion: presentationCompletion) //wip: review this (e.g. it is always animating - is that ok?)

    }

    private func determinateProgressCompletion(hudViewController a_hudViewController: IFAHudViewController) {
        IFAUtils.dispatchAsyncMainThreadBlock(
        {
            if a_hudViewController.progress == 1.0 {
                self.dismissViewControllerAnimated(true, completion: nil)   //wip: review
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
                self.dismissViewControllerAnimated(true, completion: nil)   //wip: review
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

    private func resetAppearance() {
        IFAHudView.appearance().overlayColour = nil
        IFAHudView.appearance().chromeForegroundColour = nil
        IFAHudView.appearance().chromeBackgroundColour = nil
        IFAHudView.appearance().chromeViewLayoutFittingSize = UILayoutFittingCompressedSize
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
            return TableViewRow.IndeterminateProgress
        case (1, 1):
            return TableViewRow.DeterminateProgress
        case (2, 0):
            return TableViewRow.Success
        case (2, 1):
            return TableViewRow.Error
        case (3, 0):
            return TableViewRow.ChromeTapWithAutoDismissal
        case (3, 1):
            return TableViewRow.ChromeTapWithAction
        case (3, 2):
            return TableViewRow.OverlayTapWithAutoDismissal
        case (3, 3):
            return TableViewRow.OverlayTapWithAction
        case (4, 0):
            return TableViewRow.Compressed
        case (4, 1):
            return TableViewRow.Expanded
        case (5, 0):
            return TableViewRow.CustomColours
        case (6, 0):
            return TableViewRow.DynamicLayoutWithoutAnimation
        case (6, 1):
            return TableViewRow.DynamicLayoutWithAnimation
        case (7, 0):
            return TableViewRow.BlurStyleDark
        case (7, 1):
            return TableViewRow.BlurStyleLight
        case (7, 2):
            return TableViewRow.BlurAndVibrancyStyleDark
        case (7, 3):
            return TableViewRow.BlurAndVibrancyStyleLight
        case (8, 0):
            return TableViewRow.MultipleHuds
        default:
            assert(false, "Unexpected section and row")
        }
    }
   
}

