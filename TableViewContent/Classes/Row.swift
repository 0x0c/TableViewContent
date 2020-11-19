//
//  TableViewContent.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2018/10/08.
//

import UIKit

public enum CellRepresentation {
    case nib(UINib)
    case `class`(AnyClass)
    case cellStyle(UITableViewCell.CellStyle)
}

open class RowConfiguration {
    public var title: String?
    public var detailText: String?
    public var image: UIImage?
    public var selectionStyle: UITableViewCell.SelectionStyle = .blue
    public var accessoryType: UITableViewCell.AccessoryType = .none
    public var accessoryView: UIView?
    public var editingAccessoryType: UITableViewCell.AccessoryType = .none
    public var editingAccessoryView: UIView?
    public var style: UITableViewCell.CellStyle = .default
}

public protocol RowRepresentation {
    var updateAfterSelected: Bool { get set }
    var updateAnimation: UITableView.RowAnimation { get set }
    var configuration: RowConfiguration { get set }
    var reuseIdentifier: String { get }
    var representation: CellRepresentation { get }
    var selectedAction: ((UITableView, IndexPath) -> Void)? { get }
    func prepare(_ cell: UITableViewCell, indexPath: IndexPath)
}

open class Row<Cell: UITableViewCell>: RowRepresentation {
    public var updateAfterSelected: Bool = false
    public var updateAnimation: UITableView.RowAnimation = .automatic
    public let reuseIdentifier: String
    public var configuration = RowConfiguration()
    public var selectedAction: ((UITableView, IndexPath) -> Void)?
    public let representation: CellRepresentation

    private var configure: ((Cell, IndexPath) -> Void)?
    var defaultCellConfiguration: ((Cell, IndexPath) -> Void)?

    public init(
        _ representation: CellRepresentation,
        reuseIdentifier: String
    ) {
        self.representation = representation
        self.reuseIdentifier = reuseIdentifier
    }
    
    open func prepare(_ cell: UITableViewCell, indexPath: IndexPath) {
        cell.textLabel?.text = configuration.title
        cell.detailTextLabel?.text = configuration.detailText
        cell.imageView?.image = configuration.image
        cell.selectionStyle = configuration.selectionStyle
        cell.accessoryView = configuration.accessoryView
        cell.accessoryType = configuration.accessoryType
        cell.editingAccessoryView = configuration.editingAccessoryView
        cell.editingAccessoryType = configuration.editingAccessoryType
        defaultCellConfiguration?(cell as! Cell, indexPath)
        configureCell?(cell as! Cell, indexPath)
    }
    
    @discardableResult
    open func configuration(_ configuration: RowConfiguration) -> Self {
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
    open func configure(_ configuration: ((Cell, IndexPath) -> Void)?) -> Self {
        configure = configuration
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
}
