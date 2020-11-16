//
//  ContentDelegate.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

open class Delegate: NSObject, UITableViewDelegate {
    private var dataSource: DataSource
    private var tableView: UITableView?
    open var clearSelectionAutomatically: Bool = false

    public init(dataSource: DataSource, tableView: UITableView? = nil) {
        self.dataSource = dataSource
        self.tableView = tableView
    }
    
    func reload(_ dataSource: DataSource) {
        if let tableView = tableView {
            self.dataSource = dataSource
            tableView.reloadData()
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if clearSelectionAutomatically {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let section = dataSource.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        if let action = row.selectedAction {
            action(tableView, indexPath, row.configuration)
        } else if let action = section.selectedAction {
            action(tableView, indexPath)
        }
        if row.updateAfterSelected {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    public func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let s = dataSource.sections[section]
        guard let headerView = s.headerView else {
            return nil
        }
        return headerView.sectionView
    }

    public func tableView(_: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let s = dataSource.sections[section]
        guard let footerView = s.footerView else {
            return nil
        }
        return footerView.sectionView
    }

    public func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let s = dataSource.sections[section]
        if s.headerView == nil {
            return 0
        }
        return UITableView.automaticDimension
    }

    public func tableView(_: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let s = dataSource.sections[section]
        if s.headerView == nil {
            return 0
        }
        return 1
    }

    public func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let s = dataSource.sections[section]
        if s.footerView == nil {
            return 0
        }
        return UITableView.automaticDimension
    }

    public func tableView(_: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let s = dataSource.sections[section]
        if s.footerView == nil {
            return 0
        }
        return 1
    }
}
