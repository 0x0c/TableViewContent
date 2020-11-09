//
//  TableCellContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/12.
//

import UIKit

open class DefaultRow: Row<UITableViewCell> {
    public init(title: String, style: UITableViewCell.CellStyle = .default) {
        super.init(.cellStyle(style), reuseIdentifier: "\(NSStringFromClass(DefaultRow.self))-\(style.rawValue)")
        super.title(title)
    }
}
