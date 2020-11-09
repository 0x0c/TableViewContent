//
//  TableViewContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/08.
//

import UIKit

public enum RepresentationSource {
    case nib(UINib)
    case `class`(AnyClass)
    case style(UITableViewCell.CellStyle)
}

open class RowRepresentation {
    public let source: RepresentationSource

    public let reuseIdentifier: String
    public var action: ((UITableView, IndexPath, Any?) -> Void)?
    public var data: Any?
    public var title: String?
    public var detailText: String?
    public var image: UIImage?
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var accessoryView: UIView?
    public var editingAccessoryType: UITableViewCell.AccessoryType = .none
    public var editingAccessoryView: UIView?
    public var style: UITableViewCell.CellStyle = .default

    internal var _configure: (Any, IndexPath) -> Void = { _, _ in }

    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String, data: Any? = nil) {
        source = .style(style)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
    }

    public init<Cell>(_ cellType: Cell.Type, reuseIdentifier: String, data: Any? = nil, configuration: ((Cell, IndexPath, Any?) -> Void)? = nil) {
        source = .class(cellType as! AnyClass)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
        configure(cellType, configuration: configuration)
    }

    public init<Cell>(nib: UINib, cellType: Cell.Type, reuseIdentifier: String, data: Any? = nil, configuration: ((Cell, IndexPath, Any?) -> Void)? = nil) {
        source = .nib(nib)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
        configure(cellType, configuration: configuration)
    }

    @discardableResult
    open func didSelect(_ selectedAction: @escaping (UITableView, IndexPath, Any?) -> Void) -> Self {
        action = selectedAction
        return self
    }

    @discardableResult
    open func configure<Cell>(_: Cell.Type, configuration: ((Cell, IndexPath, Any?) -> Void)?) -> Self {
        _configure = { [unowned self] cell, indexPath in
            guard let cell = cell as? Cell else {
                fatalError("Could not cast cell to \(Cell.self)")
            }

            if let configuration = configuration {
                configuration(cell, indexPath, self.data)
            }
        }

        return self
    }

    @discardableResult
    open func title(_ title: String?) -> Self {
        self.title = title
        return self
    }

    @discardableResult
    open func detailText(_ text: String?) -> Self {
        detailText = text
        return self
    }

    @discardableResult
    open func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }

    @discardableResult
    open func selectionStyle(_ style: UITableViewCell.SelectionStyle) -> Self {
        selectionStyle = style
        return self
    }

    @discardableResult
    open func accessoryType(_ type: UITableViewCell.AccessoryType) -> Self {
        accessoryType = type
        return self
    }

    @discardableResult
    open func accessoryView(_ view: UIView?) -> Self {
        accessoryView = view
        return self
    }

    @discardableResult
    open func editingAccessoryType(_ type: UITableViewCell.AccessoryType) -> Self {
        editingAccessoryType = type
        return self
    }

    @discardableResult
    open func editingAccessoryView(_ view: UIView?) -> Self {
        editingAccessoryView = view
        return self
    }
}
