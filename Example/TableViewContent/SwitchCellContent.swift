//
//  SwitchTableViewCell.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/11.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import TableViewContent

open class SwitchTableViewCell: UITableViewCell {
    private let sw = UISwitch()
    private var targetAdded = false
    public var isSwitchOn: Bool {
        get {
            return sw.isOn
        }
        set(isOn) {
            sw.isOn = isOn
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryView = sw
        self.selectionStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        if targetAdded == false {
            sw.addTarget(target, action: action, for: controlEvents)
            targetAdded = true
        }
    }
}

open class SwitchCellContent: CellContent {
    
    private var toggledAction: (Bool) -> Void = {(isOn) in }
    public var title: String
    public var isOn: Bool
    
    init(title: String, isOn: Bool = false) {
        self.title = title
        self.isOn = isOn
        super.init(SwitchTableViewCell.self, reuseIdentifier: NSStringFromClass(SwitchTableViewCell.self), data: isOn)
        self.cellConfiguration(SwitchTableViewCell.self) { [unowned self] (cell, indexPath, data) in
            cell.addTarget(self, action: #selector(self.valueChanged(_:)), for: .valueChanged)
            cell.textLabel?.text = self.title
            cell.isSwitchOn = self.isOn
        }
    }
    
    @discardableResult
    open func configure(_ configuration: @escaping (SwitchTableViewCell, IndexPath, Bool) -> Void) -> Self {
        cellConfiguration(SwitchTableViewCell.self) { [unowned self] (cell, indexPath, data) in
            cell.addTarget(self, action: #selector(self.valueChanged(_:)), for: .valueChanged)
            cell.textLabel?.text = self.title
            cell.isSwitchOn = self.isOn
            configuration(cell, indexPath, data as! Bool)
        }
        
        return self
    }
    
    @discardableResult
    open func toggleAction(_ toggleAction: @escaping (Bool) -> Void) -> Self {
        toggledAction = toggleAction
        return self
    }
    
    @objc func valueChanged(_ sender: UISwitch) {
        data = sender.isOn
        toggledAction(sender.isOn)
    }
}
