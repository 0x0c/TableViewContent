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
    public typealias Action = () -> Void

    @IBOutlet private var button: UIButton!
    var buttonPressedAction: Action = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }

    @objc
    private func buttonPressed(_: UIButton) {
        buttonPressedAction()
    }
}

class CustomRow: Row<CustomTableViewCell> {
    public typealias Action = () -> Void

    private var buttonPressedAction: Action = {}

    init() {
        super.init(
            .nib(.init(nibName: "CustomTableViewCell", bundle: nil)),
            reuseIdentifier: NSStringFromClass(CustomTableViewCell.self)
        )
        selectionStyle(.none)
    }

    override func defaultCellConfiguration(_ cell: CustomTableViewCell, _ indexPath: IndexPath) {
        cell.buttonPressedAction = buttonPressedAction
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

    @objc
    private func buttonPressed() {
        buttonPressedAction()
    }
}
