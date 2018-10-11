//
//  TableViewContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/08.
//

import UIKit

open class ContentDataSource: NSObject, UITableViewDataSource {
    open var sections: [TableViewSection] = []
    open var registeredReuseIdentifiers = [] as [String]
    
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
        
        if !registeredReuseIdentifiers.contains(row.reuseIdentifier) {
            registeredReuseIdentifiers.append(row.reuseIdentifier)
            switch row.source {
            case let .nib(nib):
                tableView.register(nib, forCellReuseIdentifier: row.reuseIdentifier)
            case let .class(cellClass):
                tableView.register(cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            }
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.configure(cell, indexPath)
        
        return cell
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

open class ContentDelegate: NSObject, UITableViewDelegate {
    private let dataSource: ContentDataSource
    
    public init(dataSource: ContentDataSource) {
        self.dataSource = dataSource
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = dataSource.sections[indexPath.section]
        let row = section.contents[indexPath.row]
        if let action = row.action {
            action(row.data, tableView, indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

open class TableViewSection: NSObject {
    open var contents: [CellContent] = []
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

open class CellContent {
    public enum RepresentationSource {
        case nib(UINib)
        case `class`(AnyClass)
    }
    
    public let source: RepresentationSource
    
    public var reuseIdentifier: String
    public var action: ((Any?, UITableView, IndexPath) -> Void)? = nil
    public var data: Any? = nil
    internal var configure: (Any, IndexPath) -> Void = {(data, indexPath) in }
    
    public init<Cell>(_ cellType: Cell.Type, reuseIdentifier: String, data: Any? = nil) {
        self.source = .class(cellType as! AnyClass)
        self.reuseIdentifier = reuseIdentifier
        self.data = data
    }
    
    public convenience init<Cell>(_ cellType: Cell.Type, reuseIdentifier: String, configuration: @escaping ((Cell, IndexPath, Any?) -> Void), data: Any? = nil) {
        self.init(cellType, reuseIdentifier: reuseIdentifier, data: data)
        let _ = self.cellConfiguration(cellType, configuration: configuration)
    }
    
    public convenience init<Cell>(nib: UINib, cellType: Cell.Type, reuseIdentifier: String, configuration: @escaping ((Cell, IndexPath, Any?) -> Void), data: Any? = nil) {
        self.init(cellType, reuseIdentifier: reuseIdentifier, data: data)
        let _ = self.cellConfiguration(cellType, configuration: configuration)
    }
    
    open func selectedAction(_ selectedAction: @escaping (Any?, UITableView, IndexPath) -> Void) -> Self {
        action = selectedAction
        return self
    }
    
    open func cellConfiguration<Cell>(_ cellType: Cell.Type, configuration: @escaping ((Cell, IndexPath, Any?) -> Void)) -> Self {
        self.configure = { [unowned self] (cell, indexPath) in
            guard let cell = cell as? Cell else {
                fatalError("Could not cast cell to \(Cell.self)")
            }
            
            configuration(cell, indexPath, self.data)
        }
        
        return self
    }
}
