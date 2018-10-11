//
//  CustomTableViewCell.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/09.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import TableViewContent

class CustomTableViewCell: UITableViewCell {
    
}

class CustomCellContent: CellContent {
    init(configuration: @escaping ((CustomTableViewCell, IndexPath, Any?) -> Void)) {
        super.init(CustomTableViewCell.self, reuseIdentifier: "CustomTableViewCell")
        let _ = self.cellConfiguration(CustomTableViewCell.self) { (cell, indexPath, data) in
            configuration(cell, indexPath, data)
        }
    }
}
