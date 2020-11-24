//
//  TableCellContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/12.
//

import UIKit

open class DefaultRow: Row<UITableViewCell> {
    public init(title: String, style: UITableViewCell.CellStyle = .default, reuseIdentifier: String? = nil) {
        var identifier: String {
            if let identifier = reuseIdentifier {
                return identifier
            }
            return "\(NSStringFromClass(Self.self))-\(style.rawValue)"
        }
        super.init(.cellStyle(style), reuseIdentifier: identifier)
        super.title(title)
    }
}
