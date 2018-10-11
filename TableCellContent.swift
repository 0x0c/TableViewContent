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
    public var style: UITableViewCell.CellStyle = .default
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var accessoryView: UIView?
    public var editingAccessoryType: UITableViewCell.AccessoryType = .none
    public var editingAccessoryView: UIView?
    
    fileprivate var contentConfiguration: (TableCellContent) -> Void = { (_) in }
    
    public init<Cell>(title: String, cellType: Cell.Type) {
        super.init(cellType, reuseIdentifier: "TableCellContent", data: title)
        self.title = title
        let _ = self.cellConfiguration(UITableViewCell.self) { [unowned self] (cell, _, _) in
            self.contentConfiguration(self)

            cell.selectionStyle = self.selectionStyle
            if self.accessoryView != nil {
                cell.accessoryView = self.accessoryView
            }
            else {
                cell.accessoryType = self.accessoryType
            }
            
            if self.editingAccessoryView != nil {
                cell.editingAccessoryView = self.editingAccessoryView
            }
            else {
                cell.editingAccessoryType = self.editingAccessoryType
            }
            
            if let image = self.image {
                cell.imageView?.image = image
            }
            if let title = self.title {
                cell.textLabel?.text = title
            }
            if let detailText = self.detailText {
                cell.detailTextLabel?.text = detailText
            }
        }
    }
    
    open func contentConfiguration(_ configuration: @escaping ((TableCellContent) -> ())) -> Self {
        contentConfiguration = configuration
        return self
    }
}

open class DefaultCellContent : TableCellContent {
    public init(title: String) {
        super.init(title: title, cellType: UITableViewCell.self)
        self.reuseIdentifier = "DefaultCell"
    }
}

class Value1Cell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class Value1CellContent : TableCellContent {
    public init(title: String) {
        super.init(title: title, cellType: Value1Cell.self)
        self.reuseIdentifier = "Value1Cell"
    }
}

class Value2Cell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class Value2CellContent : TableCellContent {
    public init(title: String) {
        super.init(title: title, cellType: Value2Cell.self)
        self.reuseIdentifier = "Value2Cell"
    }
}

class SubtitleCell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class SubtitleCellContent : TableCellContent {
    public init(title: String) {
        super.init(title: title, cellType: SubtitleCell.self)
        self.reuseIdentifier = "SubtitleCell"
    }
}
