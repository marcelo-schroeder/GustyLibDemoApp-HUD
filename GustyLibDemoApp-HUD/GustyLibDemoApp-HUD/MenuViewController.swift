//
//  MenuViewController.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 19/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    enum TableViewRow: Int {
        case TextLabel
        case DetailText
        case IndeterminateProgress
        case DeterminateProgress
        case Success
        case Error
        case UserInteractionWithAutoDismissal
        case UserInteractionWithTapAction
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

    //MARK: UITableViewControllerDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if (TableViewRow.BlurStyleDark.rawValue...TableViewRow.BlurAndVibrancyStyleLight.rawValue ~= indexPath.row) {
            return            
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        // Initialise HUD
        let chromeViewLayoutFittingMode = indexPath.row == TableViewRow.Expanded.rawValue ? IFAHudChromeViewLayoutFittingMode.Expanded : IFAHudChromeViewLayoutFittingMode.Compressed
        let hudManager: IFAHudManager = IFAHudManager(style: IFAHudViewStyle.Plain, chromeViewLayoutFittingMode: chromeViewLayoutFittingMode)

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
        case TableViewRow.UserInteractionWithAutoDismissal.rawValue:
            text = "Tap to auto dismiss"
        case TableViewRow.UserInteractionWithTapAction.rawValue:
            text = "Tap to dismiss with action"
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
        case TableViewRow.UserInteractionWithAutoDismissal.rawValue...TableViewRow.UserInteractionWithTapAction.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.ProgressIndeterminate
        default:
            visualIndicatorMode = IFAHudVisualIndicatorMode.None
        }

        // Auto dismiss delay - CHANGE TO autoDismissalDelay
        var autoDismissalDelay: NSTimeInterval?
        switch indexPath.row {
        case TableViewRow.IndeterminateProgress.rawValue:
            autoDismissalDelay = 2.0
        case TableViewRow.UserInteractionWithAutoDismissal.rawValue...TableViewRow.UserInteractionWithTapAction.rawValue:
            autoDismissalDelay = 5.0
        default:
            autoDismissalDelay = 0.5
        }

        // Tap action block
        var tapActionBlock: (() -> Void)?
        switch indexPath.row {
        case TableViewRow.UserInteractionWithTapAction.rawValue:
            tapActionBlock = {
                [unowned hudManager] in
                hudManager.dismissWithCompletion(nil)
            }
        default:
            tapActionBlock = nil
        }
        
        // Should dismiss on tap?
        var shouldDismissOnTap: Bool
        switch indexPath.row {
        case TableViewRow.UserInteractionWithAutoDismissal.rawValue:
            shouldDismissOnTap = true
        default:
            shouldDismissOnTap = false
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
        hudManager.text = text
        hudManager.detailText = detailText
        hudManager.visualIndicatorMode = visualIndicatorMode
        hudManager.tapActionBlock = tapActionBlock
        hudManager.shouldDismissOnTap = shouldDismissOnTap
        hudManager.shouldAnimateLayoutChanges = shouldAnimateLayoutChanges
        
        // Present HUD
        switch indexPath.row {
        case TableViewRow.DeterminateProgress.rawValue:
            hudManager.presentWithCompletion({ [unowned self] in
                self.determinateProgressCompletion(hudManager: hudManager)
            })
        case TableViewRow.DynamicLayoutWithoutAnimation.rawValue...TableViewRow.DynamicLayoutWithAnimation.rawValue:
            hudManager.presentWithCompletion({ [unowned self] in
                self.dynamicLayoutCompletion(hudManager: hudManager, textType: DynamicLayoutTextType(rawValue: DynamicLayoutTextType.Short.rawValue + 1)!)
            })
        default:
            hudManager.presentWithAutoDismissalDelay(autoDismissalDelay!, completion: nil)
        }

    }

    //MARK: Overrides

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let viewController = segue.destinationViewController as BlurAndVibrancyStyleViewController

        resetAppearance()

        let selectedRow = self.tableView.indexPathForSelectedRow()!.row
        let tableViewRow:TableViewRow = TableViewRow(rawValue: selectedRow)!
        
        switch tableViewRow {
        case .BlurStyleDark:
            viewController.title = "Blur style - dark"
            viewController.style = IFAHudViewStyle.Blur
            viewController.imageName = "light"
            IFAHudView.appearance().chromeForegroundColour = UIColor.whiteColor()
            IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Dark
        case .BlurStyleLight:
            viewController.title = "Blur style - light"
            viewController.style = IFAHudViewStyle.Blur
            viewController.imageName = "light"
            IFAHudView.appearance().chromeForegroundColour = UIColor.blackColor()
            IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Light
        case .BlurAndVibrancyStyleDark:
            viewController.title = "Blur and vibrancy style - dark"
            viewController.style = IFAHudViewStyle.BlurAndVibrancy
            viewController.imageName = "light"
            IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Dark
        case .BlurAndVibrancyStyleLight:
            viewController.title = "Blur and vibrancy style - light"
            viewController.style = IFAHudViewStyle.BlurAndVibrancy
            viewController.imageName = "dark"
            IFAHudView.appearance().blurEffectStyle = UIBlurEffectStyle.Light
        default:
            assert(false, "Unexpected selected row")
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
