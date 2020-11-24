//
//  CheckmarkRow.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

open class CheckmarkRow: DefaultRow {
    public var checked: Bool = false

    open override func defaultCellConfiguration(_ cell: UITableViewCell, _ indexPath: IndexPath) {
        if checked {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
    }
}
