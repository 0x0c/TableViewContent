//
//  ContentDataSource.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

@_functionBuilder
public struct SectionBuilder {
    public static func buildBlock(_ items: Section...) -> [Section] {
        items
    }
}

open class ContentDataSource: NSObject, UITableViewDataSource {
    internal var sections: [Section] = []
    open var registeredReuseIdentifiers = [] as [String]

    public init(_ sections: [Section]) {
        self.sections = sections
    }

    public init(@SectionBuilder _ sections: () -> [Section]) {
        self.sections = sections()
    }

    open func numberOfSections(in _: UITableView) -> Int {
        sections.count
    }

    open func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s = sections[section]
        return s.contents.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let row = section.contents[indexPath.row]

        switch row.source {
        case let .nib(nib):
            if !registeredReuseIdentifiers.contains(row.reuseIdentifier) {
                registeredReuseIdentifiers.append(row.reuseIdentifier)
                tableView.register(nib, forCellReuseIdentifier: row.reuseIdentifier)
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
            row._configure(cell, indexPath)
            return cell

        case let .class(cellClass):
            if !registeredReuseIdentifiers.contains(row.reuseIdentifier) {
                registeredReuseIdentifiers.append(row.reuseIdentifier)
                tableView.register(cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
            row._configure(cell, indexPath)
            return cell

        case let .style(cellStyle):
            if let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier) {
                row._configure(cell, indexPath)
                return cell
            } else {
                let cell = UITableViewCell(style: cellStyle, reuseIdentifier: row.reuseIdentifier)
                row._configure(cell, indexPath)
                return cell
            }
        }
    }

    open func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        let s = sections[section]
        switch s.headerView {
        case let .title(text):
            return text
        default:
            return nil
        }
    }

    open func tableView(_: UITableView, titleForFooterInSection section: Int) -> String? {
        let s = sections[section]
        switch s.footerView {
        case let .title(text):
            return text
        default:
            return nil
        }
    }
}
