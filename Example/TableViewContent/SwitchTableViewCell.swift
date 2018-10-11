//
//  SwitchTableViewCell.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/11.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    let sw = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryView = sw
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
