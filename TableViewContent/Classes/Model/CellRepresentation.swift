//
//  CellRepresentation.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

public enum CellRepresentation: Hashable {
    public static func == (lhs: CellRepresentation, rhs: CellRepresentation) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .nib(nib):
            hasher.combine(nib)
        case let .class(anyClass):
            hasher.combine(String(describing: anyClass))
        case let .cellStyle(cellStyle):
            hasher.combine(cellStyle)
        }
    }

    case nib(UINib)
    case `class`(AnyClass)
    case cellStyle(UITableViewCell.CellStyle)
}
