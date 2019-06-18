//
//  TableCellContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/12.
//

import UIKit

open class TableCellContent : CellContent {
    public var title: String?
    public var detailText: String?
    public var image: UIImage?
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var accessoryView: UIView?
    public var editingAccessoryType: UITableViewCell.AccessoryType = .none
    public var editingAccessoryView: UIView?
    public var style: UITableViewCell.CellStyle = .default
    
    public init<Cell>(title: String, cellType: Cell.Type, reuseIdentifier: String, style: UITableViewCell.CellStyle) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.title = title
        self.style = style
        let _ = self.cellConfiguration(UITableViewCell.self) { [unowned self] (cell, _, _) in
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
}

open class DefaultCellContent : TableCellContent {
    public init(title: String, style: UITableViewCell.CellStyle = .default) {
        super.init(title: title, cellType: UITableViewCell.self, reuseIdentifier: "\(NSStringFromClass(TableCellContent.self))-\(style.rawValue)", style: style)
    }
}
