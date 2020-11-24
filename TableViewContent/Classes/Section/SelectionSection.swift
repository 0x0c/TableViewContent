//
//  SelectionSection.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

open class SelectionSection: Section {
    public var exclusive: Bool = false
    public var destructive: Bool = false

    public convenience init(exclusive: Bool, destructive: Bool = false) {
        self.init()
        self.exclusive = exclusive
        self.destructive = destructive
    }

    override public init() {
        super.init()
        updateAnimation = .fade
        _ = didSelect { _, _ in }
    }

    override open func didSelect(_ action: @escaping (UITableView, IndexPath) -> Void) -> Self {
        selectedAction = { [unowned self] tableView, indexPath in
            action(tableView, indexPath)
            if self.exclusive {
                for (index, value) in rows.enumerated() where index != indexPath.row {
                    if let row = value as? CheckmarkRow {
                        row.checked = false
                    }
                    tableView.reloadRows(at: [IndexPath(row: index, section: indexPath.section)], with: updateAnimation)
                }
            }
            if let row = self.rows[indexPath.row] as? CheckmarkRow {
                if self.destructive {
                    row.checked = true
                }
                else {
                    row.checked.toggle()
                }
            }
            tableView.reloadRows(at: [indexPath], with: updateAnimation)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        return self
    }
}
