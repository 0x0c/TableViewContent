//
//  TableViewSection.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import Foundation

@_functionBuilder
public struct TableViewCellBuilder {
    public static func buildBlock(_ items: TableViewCellRepresentation...) -> [TableViewCellRepresentation] {
        return items
    }
}

public protocol SectionConfigurable {
    func configure(_ data: Any)
}

open class TableViewSectionView {
    public enum SectionType {
        case title(String)
        case nib(Any, UINib)
    }
    
    public typealias SectionViewRepresentation = UIView & SectionConfigurable

    private var internalView: SectionViewRepresentation?
    private(set) var sectionType: SectionType

    public init(_ type: SectionType) {
        self.sectionType = type
        switch sectionType {
        case let .nib(data, nib):
            internalView = nib.instantiate(withOwner: nil, options: nil).first as? SectionViewRepresentation
            internalView?.configure(data)
        default:
            break
        }
    }

    open func sectionView() -> UIView? {
        return internalView
    }
}

open class TableViewSection {
    internal var headerView: TableViewSectionView?
    internal var footerView: TableViewSectionView?
    internal var contents: [TableViewCellRepresentation] = []
    open var selectedAction: ((UITableView, IndexPath, Any?) -> Void)? = nil
    
    public init() {}

    public convenience init(@TableViewCellBuilder _ contents: () -> [TableViewCellRepresentation]) {
        self.init()
        self.contents = contents()
    }
    
    public convenience init(_ contents: [TableViewCellRepresentation]) {
        self.init()
        self.contents = contents
    }

    @discardableResult
    public func header(_ header: TableViewSectionView) -> Self {
        headerView = header
        return self
    }
    
    @discardableResult
    public func footer(_ footer: TableViewSectionView) -> Self {
        footerView = footer
        return self
    }
    
    @discardableResult
    public func contents(_ sectionContents: [TableViewCellRepresentation]) -> Self {
        contents = sectionContents
        return self
    }
    
    @discardableResult
    public func contents(@TableViewCellBuilder _ sectionContents: () -> [TableViewCellRepresentation]) -> Self {
        contents = sectionContents()
        return self
    }
    
    @discardableResult
    public func contents(_ closure: (TableViewSection) -> Void) -> Self {
        closure(self)
        return self
    }
    
    @discardableResult
    public func append<Content: TableViewCellRepresentation>(_ content: Content) -> Content {
        contents.append(content)
        return content
    }
    
    @discardableResult
    public func didSelected(_ action: @escaping (UITableView, IndexPath, Any?) -> Void) -> Self {
        selectedAction = action
        return self
    }
}
