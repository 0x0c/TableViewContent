//
//  TableViewContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/08.
//

import UIKit

open class TableViewContentDataSource: NSObject, UITableViewDataSource {
    open var sections: [TableViewSection] = []
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = sections[section]
        return s.contents.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let row = section.contents[indexPath.row]
        
        return row.cell(tableView, indexPath: indexPath)
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let s = sections[section]
        return s.headerTitle
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let s = sections[section]
        return s.footerTitle
    }
}

open class TableViewContentDelegate: NSObject, UITableViewDelegate {
    private let dataSource: TableViewContentDataSource
    
    public init(dataSource: TableViewContentDataSource) {
        self.dataSource = dataSource
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = dataSource.sections[indexPath.section]
        let row = section.contents[indexPath.row]
        if let action = row.action {
            action()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

open class TableViewSection: NSObject {
    open var contents: [TableViewContent] = []
    open var headerTitle: String? = nil
    open var footerTitle: String? = nil
    
    public override init() {
        super.init()
    }
    
    public init(headerTitle: String) {
        self.headerTitle = headerTitle
    }
    
    public init(footerTitle: String) {
        self.footerTitle = footerTitle
    }
    
    public convenience init(headerTitle: String, footerTitle: String) {
        self.init(headerTitle: headerTitle)
        self.footerTitle = footerTitle
    }
}

protocol Declareble {
    associatedtype Cell
}

open class TableViewContent: Declareble {
    
    public enum RepresentationSource {
        case nib(UINib)
        case `class`(AnyClass)
    }
    
    public typealias Cell = UITableViewCell
    
    public var title: String?
    public var detailText: String?
    public var image: UIImage?
    public var style: UITableViewCell.CellStyle = .default
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var accessoryView: UIView?
    public var editingAccessoryType: UITableViewCell.AccessoryType = .none
    public var editingAccessoryView: UIView?
    public let source: RepresentationSource
    public var configureCell: ((Cell) -> ())? = nil
    
    open var action: (() -> ())?
    
    open var reuseIdentifier: String = "reuseIdentifier"
    
    public init(nib: UINib) {
        self.source = .nib(nib)
    }
    
    public init(title: String, detailText: String, style: UITableViewCell.CellStyle, source: RepresentationSource) {
        self.source = source
        self.style = style
        self.title = title
        self.detailText = detailText
    }
    
    public convenience init(title: String) {
        self.init(title: title, detailText: "", style: .default, source: .class(UITableViewCell.self))
    }
    
    open func selectedAction(selectedAction: @escaping ()->()) -> Self {
        action = selectedAction
        return self
    }
    
    open func contentConfiguration(_ configuration: @escaping ((TableViewContent) -> ())) -> Self {
        configuration(self)
        return self
    }
    
    open func cellConfiguration(_ configuration: @escaping ((Cell) -> ())) -> Self {
        configureCell = configuration
        return self
    }
    
    open func staticConfiguration(_ cell: Cell) {}
    
    public func cell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch source {
        case let .nib(nib):
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        case let .class(cellClass):
            tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = detailText
        cell.selectionStyle = selectionStyle
        if accessoryView != nil {
            cell.accessoryView = accessoryView
        }
        else {
            cell.accessoryType = accessoryType
        }
        
        if editingAccessoryView != nil {
            cell.editingAccessoryView = editingAccessoryView
        }
        else {
            cell.editingAccessoryType = editingAccessoryType
        }
        
        staticConfiguration(cell)
        if let c = configureCell {
            c(cell)
        }

        return cell
    }
}
