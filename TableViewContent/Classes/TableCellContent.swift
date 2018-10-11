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
    
    fileprivate var contentConfiguration: (TableCellContent) -> Void = { (_) in }
    
    public init<Cell>(title: String, cellType: Cell.Type, reuseIdentifier: String) {
        super.init(cellType, reuseIdentifier: reuseIdentifier, data: title)
        self.title = title
        let _ = self.cellConfiguration(UITableViewCell.self) { [unowned self] (cell, _, _) in
            self.contentConfiguration(self)

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
    
    open func contentConfiguration(_ configuration: @escaping ((TableCellContent) -> ())) -> Self {
        contentConfiguration = configuration
        return self
    }
}

open class DefaultCellContent : TableCellContent {
    public init(title: String) {
        super.init(title: title, cellType: UITableViewCell.self, reuseIdentifier: NSStringFromClass(TableCellContent.self))
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
        super.init(title: title, cellType: Value1Cell.self, reuseIdentifier: NSStringFromClass(Value1Cell.self))
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
        super.init(title: title, cellType: Value2Cell.self, reuseIdentifier: NSStringFromClass(Value2Cell.self))
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
        super.init(title: title, cellType: SubtitleCell.self, reuseIdentifier: NSStringFromClass(SubtitleCell.self))
    }
}
