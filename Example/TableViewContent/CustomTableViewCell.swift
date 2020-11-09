//
//  CustomTableViewCell.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/09.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import TableViewContent
import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet var button: UIButton!
}

class CustomCell: CellRepresentation {
    public typealias Action = () -> Void

    private var buttonPressedAction: Action = {}

    init() {
        super.init(nib: UINib(nibName: "CustomTableViewCell", bundle: nil), cellType: CustomTableViewCell.self, reuseIdentifier: "CustomTableViewCell", data: nil)
        configure(CustomTableViewCell.self) { [unowned self] cell, _, _ in
            cell.button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        }
    }

    convenience init(_ action: @escaping Action) {
        self.init()
        buttonPressedAction = action
    }

    @discardableResult
    func didButtonPress(_ action: @escaping Action) -> Self {
        buttonPressedAction = action
        return self
    }

    @objc private func buttonPressed() {
        buttonPressedAction()
    }
}
