//
//  ContentDelegate.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

open class Delegate: NSObject, UITableViewDelegate {
    public enum DataSourceRepresentation {
        case plain(DataSource)
        case diffable(DiffableDataSource)

        var sections: [any Sectionable] {
            switch self {
            case let .plain(dataSource):
                return dataSource.sections
            case let .diffable(dataSource):
                return dataSource.sections
            }
        }
        
        var selectedAction: ((UITableView, IndexPath) -> Void)? {
            switch self {
            case let .plain(dataSource):
                return dataSource.selectedAction
            case let .diffable(dataSource):
                return dataSource.selectedAction
            }
        }
    }

    private var dataSource: DataSourceRepresentation
    private var tableView: UITableView
    open var clearSelectionAutomatically: Bool = false

    public init(dataSource: DataSourceRepresentation, tableView: UITableView) {
        self.dataSource = dataSource
        self.tableView = tableView
    }

    public func reload(_ dataSource: DataSourceRepresentation) {
        self.dataSource = dataSource
        tableView.reloadData()
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if clearSelectionAutomatically {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let section = dataSource.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        if let action = row.selectedAction {
            action(tableView, indexPath)
        }
        else if let action = section.selectedAction {
            action(tableView, indexPath)
        }
        else if let action = dataSource.selectedAction {
            action(tableView, indexPath)
        }

        if case let .diffable(dataSource) = dataSource {
            if section.updateAfterSelected {
                dataSource.reloadItem([AnyHashable(row)])
            }
        }
        else if case let .plain(dataSource) = dataSource {
            if section.updateAfterSelected {
                tableView.reloadSections(
                    IndexSet(integer: indexPath.section),
                    with: dataSource.sections[indexPath.section].updateAnimation
                )
            }
            else if row.updateAfterSelected {
                tableView.reloadRows(at: [indexPath], with: row.updateAnimation)
            }
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

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let section = dataSource.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        return row.trailingSwipeActionsConfiguration?()
    }

    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let section = dataSource.sections[indexPath.section]
        let row = section.rows[indexPath.row]
        return row.leadingSwipeActionsConfiguration?()
    }
}
