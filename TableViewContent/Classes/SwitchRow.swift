//
//  SwitchRow.swift
//  Pods
//
//  Created by Akira Matsuda on 2020/11/05.
//

import UIKit

open class SwitchRow: RowRepresentation {
    private var configureContent: (SwitchTableViewCell, IndexPath, Bool) -> Void = { _, _, _ in }
    private var toggledAction: (Bool) -> Void = { _ in }
    public var isOn: Bool

    public init(title: String, isOn: Bool = false) {
        self.isOn = isOn
        super.init(SwitchTableViewCell.self, reuseIdentifier: NSStringFromClass(SwitchTableViewCell.self), data: isOn)
        self.title(title)
        super.configure(SwitchTableViewCell.self) { [unowned self] cell, indexPath, data in
            cell.textLabel?.text = self.title
            cell.detailTextLabel?.text = self.detailText
            cell.imageView?.image = self.image
            cell.selectionStyle = self.selectionStyle
            cell.accessoryType = self.accessoryType
            cell.editingAccessoryView = self.editingAccessoryView
            cell.editingAccessoryType = self.editingAccessoryType
            cell.isOn = self.isOn
            cell.configure { [weak self] newValue in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.isOn = newValue
                weakSelf.toggledAction(newValue)
            }
            self.configureContent(cell, indexPath, data as! Bool)
        }
    }

    @discardableResult
    open func configure(_ configuration: @escaping (SwitchTableViewCell, IndexPath, Bool) -> Void) -> Self {
        configureContent = configuration
        return self
    }

    @discardableResult
    open func toggled(_ toggleAction: @escaping (Bool) -> Void) -> Self {
        toggledAction = toggleAction
        return self
    }
}

open class SwitchTableViewCell: UITableViewCell {
    private let sw = UISwitch()
    private var targetAdded = false
    public var isOn: Bool {
        get {
            sw.isOn
        }
        set(isOn) {
            sw.isOn = isOn
        }
    }

    private var toggledAction: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = sw
        selectionStyle = .none
        sw.addTarget(self, action: #selector(toggled(_:)), for: .valueChanged)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func toggled(_ sender: UISwitch) {
        toggledAction?(sender.isOn)
    }

    func configure(action: ((Bool) -> Void)?) {
        toggledAction = action
    }
}
