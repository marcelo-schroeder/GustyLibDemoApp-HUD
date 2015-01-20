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
        case TextLabel, DetailText, IndeterminateProgress, DeterminateProgress, Success, Error, UserInteractionWithAutoDismissal, UserInteractionWithTapAction, Compressed, Expanded, CustomColours
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
        var frameForegroundColour: UIColor?
        var frameBackgroundColour: UIColor?
        switch indexPath.row {
        case TableViewRow.CustomColours.rawValue:
            frameForegroundColour = UIColor.yellowColor()
            frameBackgroundColour = UIColor.blueColor()
        default:
            frameForegroundColour = nil
            frameBackgroundColour = nil
        }

        // Configure HUD
        hud.text = text
        hud.detailText = detailText
        hud.visualIndicatorMode = visualIndicatorMode
        hud.tapActionBlock = tapActionBlock
        hud.shouldDismissOnTap = shouldDismissOnTap
        hud.frameForegroundColour = frameForegroundColour
        hud.frameBackgroundColour = frameBackgroundColour

        // Present HUD
        if visualIndicatorMode == IFAHudVisualIndicatorMode.ProgressDeterminate {
            hud.presentWithCompletion({
                [unowned self] in
                self.completion(hud)
            })
        } else {
            hud.presentWithAutoDismissalDelay(autoDismissalDelay!, completion: nil)
        }

    }
    
    //MARK: Private
    
    private func completion(hud: IFAHud) {
        IFAUtils.dispatchAsyncMainThreadBlock(
            {
                if hud.progress == 1.0 {
                    hud.dismissWithCompletion(nil)
                } else {
                    hud.progress += 0.25
                    self.completion(hud)
                }
            }
            , afterDelay: 1)
    }

}
