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

open class SwitchCell: TableViewCellRepresentation {
    
    private var configureContent: (SwitchTableViewCell, IndexPath, Bool) -> Void = { (_, _, _) in }
    private var toggledAction: (Bool) -> Void = {(isOn) in }
    public var isOn: Bool
    
    init(title: String, isOn: Bool = false) {
        self.isOn = isOn
        super.init(SwitchTableViewCell.self, reuseIdentifier: NSStringFromClass(SwitchTableViewCell.self), data: isOn)
        self.title(title)
        super.configure(SwitchTableViewCell.self) { [unowned self] (cell, indexPath, data) in
            cell.addTarget(self, action: #selector(self.valueChanged(_:)), for: .valueChanged)
            cell.textLabel?.text = self.title
            cell.detailTextLabel?.text = self.detailText
            cell.imageView?.image = self.image
            cell.selectionStyle = self.selectionStyle
            cell.accessoryType = self.accessoryType
            cell.editingAccessoryView = self.editingAccessoryView
            cell.editingAccessoryType = self.editingAccessoryType
            
            cell.isSwitchOn = self.isOn
            self.configureContent(cell, indexPath, data as! Bool)
        }
    }
    
    @discardableResult
    open func configure(_ configuration: @escaping (SwitchTableViewCell, IndexPath, Bool) -> Void) -> Self {
        configureContent = configuration
        return self
    }
    
    @discardableResult
    open func toggle(_ toggleAction: @escaping (Bool) -> Void) -> Self {
        toggledAction = toggleAction
        return self
    }
    
    @objc func valueChanged(_ sender: UISwitch) {
        data = sender.isOn
        toggledAction(sender.isOn)
    }
}
