//
//  SwitchCellContent.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/09.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import TableViewContent

open class SwitchCellContent: CellContent {
    
    internal var toggledAction: (Bool) -> Void = {(isOn) in }
    
    init(data: Bool = false, configuration: @escaping ((SwitchTableViewCell, IndexPath, Bool) -> Void)) {
        super.init(SwitchTableViewCell.self, reuseIdentifier: "SwitchTableViewCell", data: data)
        let _ = self.cellConfiguration(SwitchTableViewCell.self) { (cell, indexPath, data) in
            cell.selectionStyle = .none
            cell.sw.addTarget(self, action: #selector(self.valueChanged(_:)), for: .valueChanged)
            configuration(cell, indexPath, data as! Bool)
        }
    }
    
    open func toggleAction(_ toggleAction: @escaping (Bool) -> Void) -> Self {
        toggledAction = toggleAction
        return self
    }
    
    @objc func valueChanged(_ sender: UISwitch) {
        data = sender.isOn
        toggledAction(sender.isOn)
    }
}
