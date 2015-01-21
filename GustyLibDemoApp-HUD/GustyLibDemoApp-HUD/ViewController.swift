//
//  ViewController.swift
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
        case DynamicLayout
    }

    enum DynamicLayoutTextType: Int {
        case Short
        case Medium
        case Long
        case End
    }

    //MARK: UITableViewControllerDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        // Initialise HUD
        let frameViewLayoutFittingMode = indexPath.row == TableViewRow.Expanded.rawValue ? IFAHudFrameViewLayoutFittingMode.Expanded : IFAHudFrameViewLayoutFittingMode.Compressed
        let hud: IFAHud = IFAHud(frameViewLayoutFittingMode: frameViewLayoutFittingMode)

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
        case TableViewRow.DynamicLayout.rawValue:
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
                [unowned hud] in
                hud.dismissWithCompletion(nil)
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

        // Custom colours
        switch indexPath.row {
        case TableViewRow.CustomColours.rawValue:
            IFAHudView.appearance().overlayColour = UIColor.blueColor().colorWithAlphaComponent(0.2)
            IFAHudView.appearance().frameForegroundColour = UIColor.yellowColor()
            IFAHudView.appearance().frameBackgroundColour = UIColor.redColor().colorWithAlphaComponent(0.75)
        default:
            IFAHudView.appearance().overlayColour = nil
            IFAHudView.appearance().frameForegroundColour = nil
            IFAHudView.appearance().frameBackgroundColour = nil
        }

        // Configure HUD
        hud.text = text
        hud.detailText = detailText
        hud.visualIndicatorMode = visualIndicatorMode
        hud.tapActionBlock = tapActionBlock
        hud.shouldDismissOnTap = shouldDismissOnTap

        // Present HUD
        switch indexPath.row {
        case TableViewRow.DeterminateProgress.rawValue:
            hud.presentWithCompletion({ [unowned self] in
                self.determinateProgressCompletion(hud: hud)
            })
        case TableViewRow.DynamicLayout.rawValue:
            hud.presentWithCompletion({ [unowned self] in
                self.dynamicLayoutCompletion(hud: hud, textType: DynamicLayoutTextType(rawValue: DynamicLayoutTextType.Short.rawValue + 1)!)
            })
        default:
            hud.presentWithAutoDismissalDelay(autoDismissalDelay!, completion: nil)
        }

    }
    
    //MARK: Private

    private func determinateProgressCompletion(hud a_hud: IFAHud) {
        IFAUtils.dispatchAsyncMainThreadBlock(
        {
            if a_hud.progress == 1.0 {
                a_hud.dismissWithCompletion(nil)
            } else {
                a_hud.progress += 0.25
                self.determinateProgressCompletion(hud: a_hud)
            }
        }
                , afterDelay: 1)
    }

    private func dynamicLayoutCompletion(hud a_hud: IFAHud, textType a_textType: DynamicLayoutTextType) {
        IFAUtils.dispatchAsyncMainThreadBlock(
        {
            if a_textType == .End {
                a_hud.dismissWithCompletion(nil)
            } else {
                a_hud.text = self.dynamicLayoutText(fromType: a_textType)
                self.dynamicLayoutCompletion(hud: a_hud, textType: DynamicLayoutTextType(rawValue: a_textType.rawValue + 1)!)
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
