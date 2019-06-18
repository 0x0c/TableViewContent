//
//  TableViewContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/08.
//

import UIKit

open class CellContent {
    public enum RepresentationSource {
        case nib(UINib)
        case `class`(AnyClass)
        case style(UITableViewCell.CellStyle)
    }
    
    public let source: RepresentationSource
    
    public let reuseIdentifier: String
    public var action: ((Any?, UITableView, IndexPath) -> Void)? = nil
    public var data: Any? = nil
    internal var configure: (Any, IndexPath) -> Void = {(data, indexPath) in }
    
    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String, data: Any? = nil) {
        self.source = .style(style)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
    }
    
    public init<Cell>(_ cellType: Cell.Type, reuseIdentifier: String, data: Any? = nil, configuration: ((Cell, IndexPath, Any?) -> Void)? = nil) {
        self.source = .class(cellType as! AnyClass)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
        self.cellConfiguration(cellType, configuration: configuration)
    }
    
    public init<Cell>(nib: UINib, cellType: Cell.Type, reuseIdentifier: String, data: Any? = nil, configuration: ((Cell, IndexPath, Any?) -> Void)? = nil) {
        self.source = .nib(nib)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
        self.cellConfiguration(cellType, configuration: configuration)
    }

    @discardableResult
    open func selectedAction(_ selectedAction: @escaping (Any?, UITableView, IndexPath) -> Void) -> Self {
        action = selectedAction
        return self
    }
    
    @discardableResult
    open func cellConfiguration<Cell>(_ cellType: Cell.Type, configuration: ((Cell, IndexPath, Any?) -> Void)?) -> Self {
        self.configure = { [unowned self] (cell, indexPath) in
            guard let cell = cell as? Cell else {
                fatalError("Could not cast cell to \(Cell.self)")
            }
            
            if let configuration = configuration {
                configuration(cell, indexPath, self.data)
            }
        }
        
        return self
    }
}
