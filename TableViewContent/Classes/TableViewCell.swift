//
//  TableCellContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/12.
//

import UIKit

open class TableViewCell: CellRepresentation {
    public init<Cell>(title: String, cellType _: Cell.Type, reuseIdentifier: String, style: UITableViewCell.CellStyle) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.title = title
        self.style = style
        configure(UITableViewCell.self) { [unowned self] cell, _, _ in
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
    open func configure(_ configuration: (TableViewCell) -> Void) -> Self {
        configuration(self)
        return self
    }
}

open class DefaultTableViewCell: TableViewCell {
    public init(title: String, style: UITableViewCell.CellStyle = .default) {
        super.init(title: title, cellType: UITableViewCell.self, reuseIdentifier: "\(NSStringFromClass(TableViewCell.self))-\(style.rawValue)", style: style)
    }
}
