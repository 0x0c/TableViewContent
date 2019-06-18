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
    @IBOutlet weak var button: UIButton!
}

class CustomCellContent: CellContent {
    private var buttonPressedAction: () -> Void = {}
    init() {
        super.init(nib: UINib(nibName: "CustomTableViewCell", bundle: nil), cellType: CustomTableViewCell.self, reuseIdentifier: "CustomTableViewCell", data: nil)
        self.cellConfiguration(CustomTableViewCell.self) { [unowned self] (cell, index, _) in
            cell.button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        }
    }
    
    @discardableResult
    func didButtonPressed(_ action: @escaping () -> Void) -> Self {
        buttonPressedAction = action
        return self
    }
    
    @objc private func buttonPressed() {
        buttonPressedAction()
    }
}
