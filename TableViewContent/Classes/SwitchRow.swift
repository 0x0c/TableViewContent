//
//  SwitchRow.swift
//  Pods
//
//  Created by Akira Matsuda on 2020/11/05.
//

import UIKit

open class SwitchRow: Row<SwitchTableViewCell> {
    private var toggledAction: ((Bool) -> Void)?
    public var isOn: Bool

    public init(title: String, isOn: Bool = false) {
        self.isOn = isOn
        super.init(
            .class(SwitchTableViewCell.self),
            reuseIdentifier: NSStringFromClass(SwitchTableViewCell.self)
        )
        self.title(title)
        selectionStyle(.none)
        configure { [unowned self] cell, _ in
            cell.prepareAccessoryView()
            cell.isOn = self.isOn
            cell.toggled { [weak self] newValue in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.isOn = newValue
                weakSelf.toggledAction?(newValue)
            }
        }
    }

    @discardableResult
    open func toggled(_ toggleAction: @escaping (Bool) -> Void) -> Self {
        toggledAction = toggleAction
        return self
    }
}

open class SwitchTableViewCell: UITableViewCell {
    private let sw = UISwitch()
    private var toggledAction: ((Bool) -> Void)?

    public var isOn: Bool {
        get {
            sw.isOn
        }
        set(isOn) {
            sw.isOn = isOn
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = sw
        sw.addTarget(self, action: #selector(_toggled(_:)), for: .valueChanged)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func _toggled(_ sender: UISwitch) {
        toggledAction?(sender.isOn)
    }

    internal func toggled(action: ((Bool) -> Void)?) {
        toggledAction = action
    }

    func prepareAccessoryView() {
        accessoryView = sw
    }
}
