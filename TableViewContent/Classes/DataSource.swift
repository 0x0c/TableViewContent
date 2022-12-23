//
//  ContentDataSource.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

@resultBuilder
public enum SectionBuilder {
    public static func buildBlock(_ items: any Sectionable...) -> [any Sectionable] {
        items
    }
}

open class DataSource: NSObject, UITableViewDataSource, DataSourceRepresentation {
    public weak var tableView: UITableView?
    public private(set) var sections: [any Sectionable] = []
    public private(set) var registeredReuseIdentifiers = [] as [String]
    open var presentSectinIndex: Bool = false
    public var selectedAction: ((UITableView, IndexPath) -> Void)?

    public init(tableView: UITableView, sections: [any Sectionable]) {
        self.tableView = tableView
        self.sections = sections
    }

    public init(tableView: UITableView, @SectionBuilder _ sections: () -> [any Sectionable]) {
        self.tableView = tableView
        self.sections = sections()
    }
    
    @discardableResult
    open func didSelect(_ action: @escaping (UITableView, IndexPath) -> Void) -> Self {
        selectedAction = { tableView, indexPath in
            action(tableView, indexPath)
        }
        return self
    }

    @discardableResult
    public func sections(_ sections: [any Sectionable]) -> Self {
        self.sections = sections
        return self
    }
    
    @discardableResult
    public func sections(_ closure: (DataSource) -> Void) -> Self {
        closure(self)
        return self
    }

    @discardableResult
    public func append(_ section: any Sectionable) -> Self {
        sections.append(section)
        return self
    }

    public func reload() {
        tableView?.reloadData()
    }

    // MARK: -

    public func numberOfSections(in _: UITableView) -> Int {
        sections.count
    }

    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = sections[section]
        return s.rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]

        switch row.representation {
        case let .nib(nibClass):
            if !registeredReuseIdentifiers.contains(row.reuseIdentifier) {
                registeredReuseIdentifiers.append(row.reuseIdentifier)
                tableView.register(nibClass, forCellReuseIdentifier: row.reuseIdentifier)
            }
        case let .class(cellClass):
            if !registeredReuseIdentifiers.contains(row.reuseIdentifier) {
                registeredReuseIdentifiers.append(row.reuseIdentifier)
                tableView.register(cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            }
        case let .cellStyle(style):
            if let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier) {
                row.prepare(cell, indexPath: indexPath)
                return cell
            }
            else {
                let cell = UITableViewCell(style: style, reuseIdentifier: row.reuseIdentifier)
                row.prepare(cell, indexPath: indexPath)
                return cell
            }
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.prepare(cell, indexPath: indexPath)
        return cell
    }

    public func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        let s = sections[section]
        switch s.headerView {
        case let .title(text):
            return text
        default:
            return nil
        }
    }

    public func tableView(_: UITableView, titleForFooterInSection section: Int) -> String? {
        let s = sections[section]
        switch s.footerView {
        case let .title(text):
            return text
        default:
            return nil
        }
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if presentSectinIndex {
            var indexTitles = [String]()
            for section in sections {
                if let title = section.sectionIndexTitle {
                    indexTitles.append(title)
                }
                else {
                    return nil
                }
            }
            return indexTitles
        }
        return nil
    }
}
