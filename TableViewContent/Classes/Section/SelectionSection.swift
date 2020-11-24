//
//  SelectionSection.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

open class SelectionSection: Section {
    public var exclusive: Bool = false

    public convenience init(exclusive: Bool) {
        self.init()
        self.exclusive = exclusive
    }

    override public init() {
        super.init()
        _ = didSelect { _, _ in }
    }

    override open func didSelect(_ action: @escaping (UITableView, IndexPath) -> Void) -> Self {
        selectedAction = { [unowned self] tableView, indexPath in
            action(tableView, indexPath)
            if let row = self.rows[indexPath.row] as? CheckmarkRow {
                row.checked.toggle()
            }
            tableView.reloadRows(at: [indexPath], with: updateAnimation)
            if self.exclusive {
                for (index, value) in rows.enumerated() where index != indexPath.row {
                    if let row = value as? CheckmarkRow {
                        row.checked = false
                    }
                    tableView.reloadRows(at: [IndexPath(row: index, section: indexPath.section)], with: updateAnimation)
                }
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
        return self
    }
}
