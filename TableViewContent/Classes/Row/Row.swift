//
//  TableViewContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/08.
//

import UIKit

open class Row<Cell: UITableViewCell>: RowRepresentation {
    private var configureCell: ((Cell, IndexPath, Row) -> Void)?
    public var prepare: ((Row) -> Void)?
    public var updateAfterSelected: Bool = false
    public var updateAnimation: UITableView.RowAnimation = .automatic
    public var configuration = CellConfiguration()
    public let reuseIdentifier: String
    public let representation: CellRepresentation
    public var selectedAction: ((UITableView, IndexPath) -> Void)?
    public var trailingSwipeActionsConfiguration: (() -> UISwipeActionsConfiguration?)?
    public var leadingSwipeActionsConfiguration: (() -> UISwipeActionsConfiguration?)?

    public init(
        _ representation: CellRepresentation,
        reuseIdentifier: String
    ) {
        self.representation = representation
        self.reuseIdentifier = reuseIdentifier
    }

    open func prepareCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        prepare?(self)
        cell.textLabel?.text = configuration.title
        cell.detailTextLabel?.text = configuration.detailText
        cell.imageView?.image = configuration.image
        cell.selectionStyle = configuration.selectionStyle
        cell.accessoryView = configuration.accessoryView
        cell.accessoryType = configuration.accessoryType
        cell.editingAccessoryView = configuration.editingAccessoryView
        cell.editingAccessoryType = configuration.editingAccessoryType
        defaultCellConfiguration(cell as! Cell, indexPath)
        configureCell?(cell as! Cell, indexPath, self)
    }

    open func defaultCellConfiguration(_ cell: Cell, _ indexPath: IndexPath) {}

    @discardableResult
    open func prepare(_ prepare: @escaping (Row) -> Void) -> Self {
        self.prepare = prepare
        return self
    }

    @discardableResult
    open func configuration(_ configuration: CellConfiguration) -> Self {
        self.configuration = configuration
        return self
    }

    @discardableResult
    open func updateAfterSelected(_ update: Bool, animation: UITableView.RowAnimation = .automatic) -> Self {
        updateAfterSelected = update
        updateAnimation = animation
        return self
    }

    @discardableResult
    open func configureCell(_ configuration: ((Cell, IndexPath, Row) -> Void)?) -> Self {
        configureCell = configuration
        return self
    }

    @discardableResult
    open func didSelect(_ action: @escaping (UITableView, IndexPath, Row) -> Void) -> Self {
        selectedAction = { tableView, indexPath in
            action(tableView, indexPath, self)
        }
        return self
    }

    @discardableResult
    open func title(_ title: String?) -> Self {
        configuration.title = title
        return self
    }

    @discardableResult
    open func detailText(_ text: String?) -> Self {
        configuration.detailText = text
        return self
    }

    @discardableResult
    open func image(_ image: UIImage?) -> Self {
        configuration.image = image
        return self
    }

    @discardableResult
    open func selectionStyle(_ style: UITableViewCell.SelectionStyle) -> Self {
        configuration.selectionStyle = style
        return self
    }

    @discardableResult
    open func accessoryType(_ type: UITableViewCell.AccessoryType) -> Self {
        configuration.accessoryType = type
        return self
    }

    @discardableResult
    open func accessoryView(_ view: UIView?) -> Self {
        configuration.accessoryView = view
        return self
    }

    @discardableResult
    open func editingAccessoryType(_ type: UITableViewCell.AccessoryType) -> Self {
        configuration.editingAccessoryType = type
        return self
    }

    @discardableResult
    open func editingAccessoryView(_ view: UIView?) -> Self {
        configuration.editingAccessoryView = view
        return self
    }

    @discardableResult
    open func trailingSwipeActions(_ actions: @escaping () -> UISwipeActionsConfiguration?) -> Self {
        trailingSwipeActionsConfiguration = actions
        return self
    }

    @discardableResult
    open func leadingSwipeActions(_ actions: @escaping () -> UISwipeActionsConfiguration?) -> Self {
        leadingSwipeActionsConfiguration = actions
        return self
    }
}
