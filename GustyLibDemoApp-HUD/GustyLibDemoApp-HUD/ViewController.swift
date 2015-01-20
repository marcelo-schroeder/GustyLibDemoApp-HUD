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
        case TextLabel, DetailText, IndeterminateProgress, DeterminateProgress, Ok, Error, UserInteraction
    }

    //MARK: UITableViewControllerDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        // Initialise HUD
        let hud = IFAHud()

        // Text
        var text: String?
        switch indexPath.row {
        case TableViewRow.UserInteraction.rawValue:
            text = "Tap to cancel"
        case TableViewRow.TextLabel.rawValue...TableViewRow.UserInteraction.rawValue:
            text = "Text label"
        default:
            text = nil
        }
        
        // Detail text
        var detailText: String?;
        switch indexPath.row {
        case TableViewRow.DetailText.rawValue...TableViewRow.DeterminateProgress.rawValue:
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
        case TableViewRow.Ok.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.Success
        case TableViewRow.Error.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.Error
        case TableViewRow.UserInteraction.rawValue:
            visualIndicatorMode = IFAHudVisualIndicatorMode.ProgressIndeterminate
        default:
            visualIndicatorMode = IFAHudVisualIndicatorMode.None
        }

        // Auto dismiss delay - CHANGE TO autoDismissalDelay
        var autoDismissalDelay: NSTimeInterval?
        switch indexPath.row {
        case TableViewRow.IndeterminateProgress.rawValue:
            autoDismissalDelay = 2.0
        case TableViewRow.UserInteraction.rawValue:
            autoDismissalDelay = 5.0
        default:
            autoDismissalDelay = 0.5
        }

        // Tap action block
        var tapActionBlock: (() -> Void)?
        switch indexPath.row {
        case TableViewRow.UserInteraction.rawValue:
            tapActionBlock = {
                [unowned hud] in
                hud.dismissWithCompletion(nil)
            }
        default:
            tapActionBlock = nil
        }

        // Configure HUD
        hud.text = text
        hud.detailText = detailText
        hud.visualIndicatorMode = visualIndicatorMode
        hud.tapActionBlock = tapActionBlock

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
