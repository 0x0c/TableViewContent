//
//  DataSourceRepresentation.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2022/12/23.
//

import UIKit

public protocol DataSourceRepresentation {
    var sections: [any Sectionable] { get }
    var selectedAction: ((UITableView, IndexPath) -> Void)? { get set }
    func reload()
}
