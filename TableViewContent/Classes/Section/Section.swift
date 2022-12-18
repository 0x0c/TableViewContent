//
//  TableViewSection.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

@resultBuilder
public enum CellBuilder {
    public static func buildBlock(_ items: any RowRepresentation...) -> [any RowRepresentation] {
        items
    }
}

public typealias SectionViewRepresentation = UIView & SectionConfigurable

open class Section: Sectionable {
    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func registerCell(tableView: UITableView) {
        for row in rows {
            switch row.representation {
            case let .nib(nibClass):
                tableView.register(nibClass, forCellReuseIdentifier: row.reuseIdentifier)
            case let .class(cellClass):
                tableView.register(cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            case .cellStyle:
                break
            }
        }
    }
    
    public func cell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        let row = rows[indexPath.row]
        switch row.representation {
        case .nib, .class:
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
            row.prepare(cell, indexPath: indexPath)
            return cell
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
    }

    open var selectedAction: ((UITableView, IndexPath) -> Void)?
    public var updateAfterSelected: Bool = false
    public var updateAnimation: UITableView.RowAnimation = .automatic
    public var headerView: SectionSupplementalyView?
    public var footerView: SectionSupplementalyView?
    public var rows = [any RowRepresentation]()
    public var sectionIndexTitle: String?

    public init() {}

    public convenience init(@CellBuilder _ rows: () -> [any RowRepresentation]) {
        self.init()
        self.rows = rows()
    }

    public convenience init(_ rows: [any RowRepresentation]) {
        self.init()
        self.rows = rows
    }

    @discardableResult
    open func sectionIndexTitle(_ title: String) -> Self {
        sectionIndexTitle = title
        return self
    }

    @discardableResult
    open func header(_ header: SectionSupplementalyView) -> Self {
        headerView = header
        return self
    }

    @discardableResult
    open func footer(_ footer: SectionSupplementalyView) -> Self {
        footerView = footer
        return self
    }

    @discardableResult
    open func rows(_ sectionContents: [any RowRepresentation]) -> Self {
        rows = sectionContents
        return self
    }

    @discardableResult
    open func rows(@CellBuilder _ sectionContents: () -> [any RowRepresentation]) -> Self {
        rows = sectionContents()
        return self
    }

    @discardableResult
    open func rows(_ closure: (Section) -> Void) -> Self {
        closure(self)
        return self
    }

    @discardableResult
    open func append(_ row: any RowRepresentation) -> Self {
        rows.append(row)
        return self
    }

    @discardableResult
    open func append(contentsOf elements: [any RowRepresentation]) -> Self {
        rows.append(contentsOf: elements)
        return self
    }

    @discardableResult
    open func didSelect(_ action: @escaping (UITableView, IndexPath) -> Void) -> Self {
        selectedAction = action
        return self
    }
}
