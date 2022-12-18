//
//  CellConfiguration.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

open class CellConfiguration: Hashable {
    public static func == (lhs: CellConfiguration, rhs: CellConfiguration) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(detailText)
        hasher.combine(image)
        hasher.combine(selectionStyle)
        hasher.combine(accessoryType)
        hasher.combine(accessoryView)
        hasher.combine(editingAccessoryType)
        hasher.combine(editingAccessoryView)
        hasher.combine(style)
    }
    
    public var title: String?
    public var detailText: String?
    public var image: UIImage?
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var accessoryView: UIView?
    public var editingAccessoryType: UITableViewCell.AccessoryType = .none
    public var editingAccessoryView: UIView?
    public var style: UITableViewCell.CellStyle = .default
}
