//
//  RowRepresentation.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

public protocol RowRepresentation: Hashable {
    var updateAfterSelected: Bool { get set }
    var updateAnimation: UITableView.RowAnimation { get set }
    var configuration: CellConfiguration { get set }
    var reuseIdentifier: String { get }
    var representation: CellRepresentation { get }
    var selectedAction: ((UITableView, IndexPath) -> Void)? { get }
    var trailingSwipeActionsConfiguration: (() -> UISwipeActionsConfiguration?)? { get set }
    var leadingSwipeActionsConfiguration: (() -> UISwipeActionsConfiguration?)? { get set }
    func prepare(_ cell: UITableViewCell, indexPath: IndexPath)
}

extension RowRepresentation {
    public static func == (lhs: any RowRepresentation, rhs: any RowRepresentation) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(configuration)
        hasher.combine(representation)
    }
}
