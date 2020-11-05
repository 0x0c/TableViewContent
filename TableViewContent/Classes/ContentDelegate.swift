//
//  ContentDelegate.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import Foundation

open class ContentDelegate: NSObject, UITableViewDelegate {
    private let dataSource: ContentDataSource
    
    public init(dataSource: ContentDataSource) {
        self.dataSource = dataSource
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = dataSource.sections[indexPath.section]
        let row = section.contents[indexPath.row]
        if let action = row.action {
            action(tableView, indexPath, row.data)
        }
        else if let action = section.selectedAction {
            action(tableView, indexPath, row.data)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let s = dataSource.sections[section]
        guard let headerView = s.headerView else {
            return nil
        }
        return headerView.sectionView
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let s = dataSource.sections[section]
        guard let footerView = s.footerView else {
            return nil
        }
        return footerView.sectionView
    }
}
