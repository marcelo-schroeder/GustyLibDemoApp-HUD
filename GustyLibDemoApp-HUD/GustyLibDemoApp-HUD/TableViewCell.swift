//
//  TableViewCell.swift
//  GustyLibDemoApp-HUD
//
//  Created by Marcelo Schroeder on 27/01/2015.
//  Copyright (c) 2015 InfoAccent Pty Ltd. All rights reserved.
//

import Foundation

class TableViewCell: UITableViewCell {
    
    //MARK: Overrides
    
    override func awakeFromNib() {
        self.textLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
}