//
//  MenuViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 19/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    enum TableViewRow: Int {
        case TextLabel
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
    }

    enum DynamicLayoutTextType: Int {
        case Short
        case Medium
        case Long
        case End
    }

    var hudManager: IFAHudManager!

    //MARK: UITableViewControllerDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if (TableViewRow.BlurStyleDark.rawValue...TableViewRow.BlurAndVibrancyStyleLight.rawValue ~= indexPath.row) {
            return            
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        // Initialise HUD
        let chromeViewLayoutFittingMode = indexPath.row == TableViewRow.Expanded.rawValue ? IFAHudChromeViewLayoutFittingMode.Expanded : IFAHudChromeViewLayoutFittingMode.Compressed
        self.hudManager = IFAHudManager(style: IFAHudViewStyle.Plain, chromeViewLayoutFittingMode: chromeViewLayoutFittingMode)

        // Text
        var text: String?
        switch indexPath.row {
        case TableViewRow.TextLabel.rawValue...TableViewRow.DetailText.rawValue:
            text = "Text label"
        case TableViewRow.IndeterminateProgress.rawValue:
            text = "Indeterminate progress"
        case TableViewRow.DeterminateProgress.rawValue:
            text = "Determinate progress"
        case TableViewRow.Success.rawValue:
            text = "Success"
        case TableViewRow.Error.rawValue:
            text = "Error"
        case TableViewRow.ChromeTapWithAutoDismissal.rawValue:
            text = "Tap inside to auto dismiss"
        case TableViewRow.ChromeTapWithAction.rawValue:
            text = "Tap inside to dismiss with action"
        case TableViewRow.OverlayTapWithAutoDismissal.rawValue:
            text = "Tap outside to auto dismiss"
        case TableViewRow.OverlayTapWithAction.rawValue:
            text = "Tap outside to dismiss with action"
        case TableViewRow.Compressed.rawValue:
            text = "Compressed"
        case TableViewRow.Expanded.rawValue:
            text = "Expanded"
        case TableViewRow.CustomColours.rawValue:
            text = "Custom colours"
        case TableViewRow.DynamicLayoutWithoutAnimation.rawValue...TableViewRow.DynamicLayoutWithAnimation.rawValue:
            text = dynamicLayoutText(fromType: DynamicLayoutTextType.Short)
        default:
            text = nil
        }
        
        // Detail text
        var detailText: String?;
        switch indexPath.row {
        case TableViewRow.DetailText.rawValue:
            detailText = "Detail text label"
        default:
            detailText = nil
        }

        // Visual indicator mode
        var visualIndicatorMode: IFAHudVisualIndicatorMode
        switch indexPath.row {
        case TableViewRow.IndeterminateProgress.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.ProgressIndeterminate
        case TableViewRow.DeterminateProgress.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.ProgressDeterminate
        case TableViewRow.Success.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.Success
        case TableViewRow.Error.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.Error
        case TableViewRow.ChromeTapWithAutoDismissal.rawValue...TableViewRow.OverlayTapWithAction.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.ProgressIndeterminate
        default:
            visualIndicatorMode = IFAHudVisualIndicatorMode.None
        }

        // Auto dismissal delay
        var autoDismissalDelay: NSTimeInterval?
        switch indexPath.row {
        case TableViewRow.IndeterminateProgress.rawValue:
            autoDismissalDelay = 2.0
        case TableViewRow.ChromeTapWithAutoDismissal.rawValue...TableViewRow.OverlayTapWithAction.rawValue:
            autoDismissalDelay = 0.0
        default:
            autoDismissalDelay = 0.5
        }

        // Chrome tap action block
        var chromeTapActionBlock: (() -> Void)?
        switch indexPath.row {
        case TableViewRow.ChromeTapWithAction.rawValue:
            chromeTapActionBlock = {
                [unowned self] in
                self.hudManager.dismissWithCompletion(nil)
            }
        default:
            chromeTapActionBlock = nil
        }
        
        // Should dismiss on chrome tap?
        var shouldDismissOnChromeTap: Bool
        switch indexPath.row {
        case TableViewRow.ChromeTapWithAutoDismissal.rawValue:
            shouldDismissOnChromeTap = true
        default:
            shouldDismissOnChromeTap = false
        }
        
        // Overlay tap action block
        var overlayTapActionBlock: (() -> Void)?
        switch indexPath.row {
        case TableViewRow.OverlayTapWithAction.rawValue:
            overlayTapActionBlock = {
                [unowned self] in
                self.hudManager.dismissWithCompletion(nil)
            }
        default:
            overlayTapActionBlock = nil
        }
        
        // Should dismiss on overlay tap?
        var shouldDismissOnOverlayTap: Bool
        switch indexPath.row {
        case TableViewRow.OverlayTapWithAutoDismissal.rawValue:
            shouldDismissOnOverlayTap = true
        default:
            shouldDismissOnOverlayTap = false
        }
        
        // Should animate layout changes?
        var shouldAnimateLayoutChanges: Bool
        switch indexPath.row {
        case TableViewRow.DynamicLayoutWithAnimation.rawValue:
            shouldAnimateLayoutChanges = true
        default:
            shouldAnimateLayoutChanges = false
        }

        // Custom colours
        switch indexPath.row {
        case TableViewRow.CustomColours.rawValue:
            IFAHudView.appearance().overlayColour = UIColor.blueColor().colorWithAlphaComponent(0.2)
            IFAHudView.appearance().chromeForegroundColour = UIColor.yellowColor()
            IFAHudView.appearance().chromeBackgroundColour = UIColor.redColor().colorWithAlphaComponent(0.75)
        default:
            resetAppearance()
        }

        // Configure HUD
        self.hudManager.text = text
        self.hudManager.detailText = detailText
        self.hudManager.visualIndicatorMode = visualIndicatorMode
        self.hudManager.chromeTapActionBlock = chromeTapActionBlock
        self.hudManager.shouldDismissOnChromeTap = shouldDismissOnChromeTap
        self.hudManager.overlayTapActionBlock = overlayTapActionBlock
        self.hudManager.shouldDismissOnOverlayTap = shouldDismissOnOverlayTap
        self.hudManager.shouldAnimateLayoutChanges = shouldAnimateLayoutChanges
        
        // Present HUD
        switch indexPath.row {
        case TableViewRow.DeterminateProgress.rawValue:
            self.hudManager.presentWithCompletion({ [unowned self] in
                self.determinateProgressCompletion(hudManager: self.hudManager)
            })
        case TableViewRow.DynamicLayoutWithoutAnimation.rawValue...TableViewRow.DynamicLayoutWithAnimation.rawValue:
            self.hudManager.presentWithCompletion({ [unowned self] in
                self.dynamicLayoutCompletion(hudManager: self.hudManager, textType: DynamicLayoutTextType(rawValue: DynamicLayoutTextType.Short.rawValue + 1)!)
            })
        default:
            self.hudManager.presentWithAutoDismissalDelay(autoDismissalDelay!, completion: nil)
        }

    }

    //MARK: Overrides

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.destinationViewController is BlurAndVibrancyStyleViewController) {
            
            let viewController = segue.destinationViewController as BlurAndVibrancyStyleViewController
            
            resetAppearance()
            
            let selectedRow = self.tableView.indexPathForSelectedRow()!.row
            let tableViewRow:TableViewRow = TableViewRow(rawValue: selectedRow)!
            
            switch tableViewRow {
            case .BlurStyleDark:
                viewController.text = "Blur style - dark"
                viewController.style = IFAHudViewStyle.Blur
                viewController.imageName = "windsurf"
                IFAHudView.appearance().chromeForegroundColour = UIColor.whiteColor()
                IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Dark
            case .BlurStyleLight:
                viewController.text = "Blur style - light"
                viewController.style = IFAHudViewStyle.Blur
                viewController.imageName = "windsurf"
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

    private func determinateProgressCompletion(hudManager a_hudManager: IFAHudManager) {
        IFAUtils.dispatchAsyncMainThreadBlock(
        {
            if a_hudManager.progress == 1.0 {
                a_hudManager.dismissWithCompletion(nil)
            } else {
                a_hudManager.progress += 0.25
                self.determinateProgressCompletion(hudManager: a_hudManager)
            }
        }
                , afterDelay: 1)
    }

    private func dynamicLayoutCompletion(hudManager a_hudManager: IFAHudManager, textType a_textType: DynamicLayoutTextType) {
        IFAUtils.dispatchAsyncMainThreadBlock(
        {
            if a_textType == .End {
                a_hudManager.dismissWithCompletion(nil)
            } else {
                a_hudManager.text = self.dynamicLayoutText(fromType: a_textType)
                self.dynamicLayoutCompletion(hudManager: a_hudManager, textType: DynamicLayoutTextType(rawValue: a_textType.rawValue + 1)!)
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
    }

}
