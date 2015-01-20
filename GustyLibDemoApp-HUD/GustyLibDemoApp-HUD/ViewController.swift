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
        case TextLabel, DetailText, IndeterminateProgress, DeterminateProgress
    }

    //MARK: UITableViewControllerDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Text
        var text: String?
        switch indexPath.row {
        case TableViewRow.TextLabel.rawValue...TableViewRow.DeterminateProgress.rawValue:
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

        // Progress mode
        var progressMode: IFAHudProgressMode
        switch indexPath.row {git
        case TableViewRow.IndeterminateProgress.rawValue:
            progressMode = IFAHudProgressMode.Indeterminate
        case TableViewRow.DeterminateProgress.rawValue:
            progressMode = IFAHudProgressMode.Determinate
        default:
            progressMode = IFAHudProgressMode.None
        }

        // Auto dismiss delay - CHANGE TO autoDismissalDelay
        var autoDismissalDelay: NSTimeInterval?
        switch indexPath.row {
        case TableViewRow.TextLabel.rawValue...TableViewRow.DetailText.rawValue:
            autoDismissalDelay = 0.5
        case TableViewRow.IndeterminateProgress.rawValue:
            autoDismissalDelay = 2.0
        default:
            autoDismissalDelay = nil
        }
        
        let hud = IFAHud()
        hud.text = text
        hud.detailText = detailText
        hud.progressMode = progressMode

        if progressMode == IFAHudProgressMode.Determinate {
            hud.presentWithCompletion({[unowned self] in self.completion(hud)})
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
