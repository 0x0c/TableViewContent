//
//  CellRepresentation.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

public enum CellRepresentation {
    case nib(UINib)
    case `class`(AnyClass)
    case cellStyle(UITableViewCell.CellStyle)
}
