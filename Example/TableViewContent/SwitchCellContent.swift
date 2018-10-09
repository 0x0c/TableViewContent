//
//  SwitchCellContent.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/09.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import TableViewContent

open class SwitchCellContent: TableViewContent {
    let sw = UISwitch()
    
    open override func configure(_ cell: TableViewContent.Cell) {
        sw.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        cell.accessoryView = sw
        self.selectedAction = { [unowned self] in
            self.toggle()
        }
    }
    
    func toggle() {
        sw.setOn(!sw.isOn, animated: true)
    }
    
    @objc func valueChanged() {
        print("\(sw.isOn)")
    }
}
