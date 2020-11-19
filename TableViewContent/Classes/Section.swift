//
//  TableViewSection.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

@_functionBuilder
public enum CellBuilder {
    public static func buildBlock(_ items: RowRepresentation...) -> [RowRepresentation] {
        items
    }
}

public protocol SectionConfigurable {
    func configure(_ data: Any)
}

public typealias SectionViewRepresentation = UIView & SectionConfigurable

public enum SectionSupplementalyView {
    case title(String)
    case nib(UINib, Any)
    case view(UIView & SectionConfigurable, Any)

    var sectionView: UIView? {
        switch self {
        case .title:
            return nil
        case let .nib(nib, data):
            let internalView = nib.instantiate(withOwner: nil, options: nil).first as? SectionViewRepresentation
            internalView?.configure(data)
            return internalView
        case let .view(sectionView, data):
            let internalView = sectionView
            internalView.configure(data)
            return internalView
        }
    }
}

open class Section {
    open var selectedAction: ((UITableView, IndexPath) -> Void)?
    var headerView: SectionSupplementalyView?
    var footerView: SectionSupplementalyView?
    var rows = [RowRepresentation]()
    var sectionIndexTitle: String?

    public init() {}

    public convenience init(@CellBuilder _ rows: () -> [RowRepresentation]) {
        self.init()
        self.rows = rows()
    }

    public convenience init(_ rows: [RowRepresentation]) {
        self.init()
        self.rows = rows
    }

    @discardableResult
    public func sectionIndexTitle(_ title: String) -> Self {
        sectionIndexTitle = title
        return self
    }

    @discardableResult
    public func header(_ header: SectionSupplementalyView) -> Self {
        headerView = header
        return self
    }

    @discardableResult
    public func footer(_ footer: SectionSupplementalyView) -> Self {
        footerView = footer
        return self
    }

    @discardableResult
    public func rows(_ sectionContents: [RowRepresentation]) -> Self {
        rows = sectionContents
        return self
    }

    @discardableResult
    public func rows(@CellBuilder _ sectionContents: () -> [RowRepresentation]) -> Self {
        rows = sectionContents()
        return self
    }

    @discardableResult
    public func rows(_ closure: (Section) -> Void) -> Self {
        closure(self)
        return self
    }

    @discardableResult
    public func append(_ row: RowRepresentation) -> Self {
        rows.append(row)
        return self
    }

    @discardableResult
    public func didSelect(_ action: @escaping (UITableView, IndexPath) -> Void) -> Self {
        selectedAction = action
        return self
    }
}
