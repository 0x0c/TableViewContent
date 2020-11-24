//
//  ColorHeaderView.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2020/11/25.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import TableViewContent
import UIKit

class ColorHeaderView: UIView, SectionConfigurable {
    init(height: CGFloat) {
        super.init(frame: .zero)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ data: Any) {
        guard let color = data as? UIColor else {
            return
        }
        backgroundColor = color
    }
}
