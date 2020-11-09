//
//  CustomHeaderView.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2020/11/05.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

import TableViewContent

class CustomHeaderView: UIView, TableViewContent.SectionConfigurable {
    @IBOutlet var headerTitle: UILabel!

    func configure(_ data: Any) {
        guard let data = data as? String else {
            return
        }
        headerTitle.text = data
    }
}
