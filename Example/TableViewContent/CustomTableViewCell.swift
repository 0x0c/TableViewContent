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
    init() {
        super.init(nib: UINib(nibName: "CustomTableViewCell", bundle: nil), cellType: CustomTableViewCell.self, reuseIdentifier: "CustomTableViewCell")
    }
    
    init(_ configuration: ((CustomTableViewCell, IndexPath, Any?) -> Void)?) {
        super.init(nib: UINib(nibName: "CustomTableViewCell", bundle: nil), cellType: CustomTableViewCell.self, reuseIdentifier: "CustomTableViewCell", configuration: configuration)
    }
}
