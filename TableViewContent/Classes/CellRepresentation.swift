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

open class CellRepresentation {
    public let source: RepresentationSource
    
    public let reuseIdentifier: String
    public var action: ((UITableView, IndexPath, Any?) -> Void)? = nil
    public var data: Any? = nil
    public var title: String?
    public var detailText: String?
    public var image: UIImage?
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var accessoryView: UIView?
    public var editingAccessoryType: UITableViewCell.AccessoryType = .none
    public var editingAccessoryView: UIView?
    public var style: UITableViewCell.CellStyle = .default
    
    internal var _configure: (Any, IndexPath) -> Void = {(data, indexPath) in }
    
    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String, data: Any? = nil) {
        self.source = .style(style)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
    }
    
    public init<Cell>(_ cellType: Cell.Type, reuseIdentifier: String, data: Any? = nil, configuration: ((Cell, IndexPath, Any?) -> Void)? = nil) {
        self.source = .class(cellType as! AnyClass)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
        self.configure(cellType, configuration: configuration)
    }
    
    public init<Cell>(nib: UINib, cellType: Cell.Type, reuseIdentifier: String, data: Any? = nil, configuration: ((Cell, IndexPath, Any?) -> Void)? = nil) {
        self.source = .nib(nib)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
        self.configure(cellType, configuration: configuration)
    }

    @discardableResult
    open func didSelect(_ selectedAction: @escaping (UITableView, IndexPath, Any?) -> Void) -> Self {
        action = selectedAction
        return self
    }
    
    @discardableResult
    open func configure<Cell>(_ cellType: Cell.Type, configuration: ((Cell, IndexPath, Any?) -> Void)?) -> Self {
        self._configure = { [unowned self] (cell, indexPath) in
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
        self.detailText = text
        return self
    }
    
    @discardableResult
    open func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    @discardableResult
    open func selectionStyle(_ style: UITableViewCell.SelectionStyle) -> Self {
        self.selectionStyle = style
        return self
    }
    
    @discardableResult
    open func accessoryType(_ type: UITableViewCell.AccessoryType) -> Self {
        self.accessoryType = type
        return self
    }
    
    @discardableResult
    open func accessoryView(_ view: UIView?) -> Self {
        self.accessoryView = view
        return self
    }
    
    @discardableResult
    open func editingAccessoryType(_ type: UITableViewCell.AccessoryType) -> Self {
        self.editingAccessoryType = type
        return self
    }
    
    @discardableResult
    open func editingAccessoryView(_ view: UIView?) -> Self {
        self.editingAccessoryView = view
        return self
    }
}
