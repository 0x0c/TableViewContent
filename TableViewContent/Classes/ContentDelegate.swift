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
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
