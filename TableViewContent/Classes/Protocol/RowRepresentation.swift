//
//  RowRepresentation.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

public protocol RowRepresentation {
    var updateAfterSelected: Bool { get set }
    var updateAnimation: UITableView.RowAnimation { get set }
    var configuration: CellConfiguration { get set }
    var reuseIdentifier: String { get }
    var representation: CellRepresentation { get }
    var selectedAction: ((UITableView, IndexPath) -> Void)? { get }
    var trailingSwipeActionsConfiguration: (() -> UISwipeActionsConfiguration?)? { get set }
    var leadingSwipeActionsConfiguration: (() -> UISwipeActionsConfiguration?)? { get set }
    func prepareCell(_ cell: UITableViewCell, indexPath: IndexPath)
}
