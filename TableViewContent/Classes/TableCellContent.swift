//
//  TableCellContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/12.
//

import UIKit

open class TableCellContent : CellContent {
    internal var title: String?
    internal var detailText: String?
    internal var image: UIImage?
    internal var selectionStyle: UITableViewCell.SelectionStyle = .blue
    internal var accessoryType: UITableViewCell.AccessoryType = .none
    internal var accessoryView: UIView?
    internal var editingAccessoryType: UITableViewCell.AccessoryType = .none
    internal var editingAccessoryView: UIView?
    internal var style: UITableViewCell.CellStyle = .default
    
    public init<Cell>(title: String, cellType: Cell.Type, reuseIdentifier: String, style: UITableViewCell.CellStyle) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.title = title
        self.style = style
        self.cellConfiguration(UITableViewCell.self) { [unowned self] (cell, _, _) in
            cell.textLabel?.text = self.title
            cell.detailTextLabel?.text = self.detailText
            cell.imageView?.image = self.image
            
            cell.selectionStyle = self.selectionStyle
            
            cell.accessoryView = self.accessoryView
            cell.accessoryType = self.accessoryType
            
            cell.editingAccessoryView = self.editingAccessoryView
            cell.editingAccessoryType = self.editingAccessoryType
        }
    }
    
    @discardableResult
    open func configure(_ configuration: ((TableCellContent) -> ())) -> Self {
        configuration(self)
        return self
    }
    
    @discardableResult
    open func title(_ title: String) -> Self {
        self.title = title
        return self
    }
    
    @discardableResult
    open func detailText(_ text: String) -> Self {
        self.detailText = text
        return self
    }
    
    @discardableResult
    open func image(_ image: UIImage) -> Self {
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
    open func accessoryView(_ view: UIView) -> Self {
        self.accessoryView = view
        return self
    }
    
    @discardableResult
    open func editingAccessoryType(_ type: UITableViewCell.AccessoryType) -> Self {
        self.editingAccessoryType = type
        return self
    }
    
    @discardableResult
    open func editingAccessoryView(_ view: UIView) -> Self {
        self.editingAccessoryView = view
        return self
    }
}

open class DefaultCellContent : TableCellContent {
    public init(title: String, style: UITableViewCell.CellStyle = .default) {
        super.init(title: title, cellType: UITableViewCell.self, reuseIdentifier: "\(NSStringFromClass(TableCellContent.self))-\(style.rawValue)", style: style)
    }
}
