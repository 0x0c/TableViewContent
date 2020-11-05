//
//  TableViewSection.swift
//  Pods-TableViewContent_Example
//
//  Created by Akira Matsuda on 2019/06/19.
//

import UIKit

@_functionBuilder
public struct CellBuilder {
    public static func buildBlock(_ items: CellRepresentation...) -> [CellRepresentation] {
        return items
    }
}

public protocol SectionConfigurable {
    func configure(_ data: Any)
}

public typealias SectionViewRepresentation = UIView & SectionConfigurable

public enum SectionSupplementalyView {
    case title(String)
    case nib(Any, UINib)

    var sectionView: UIView? {
        switch self {
        case .title(_):
            return nil
        case let .nib(data, nib):
            let internalView = nib.instantiate(withOwner: nil, options: nil).first as? SectionViewRepresentation
            internalView?.configure(data)
            return internalView
        }
    }
}

open class Section {
    internal var headerView: SectionSupplementalyView?
    internal var footerView: SectionSupplementalyView?
    internal var contents: [CellRepresentation] = []
    open var selectedAction: ((UITableView, IndexPath, Any?) -> Void)? = nil
    
    public init() {}

    public convenience init(@CellBuilder _ contents: () -> [CellRepresentation]) {
        self.init()
        self.contents = contents()
    }
    
    public convenience init(_ contents: [CellRepresentation]) {
        self.init()
        self.contents = contents
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
    public func contents(_ sectionContents: [CellRepresentation]) -> Self {
        contents = sectionContents
        return self
    }
    
    @discardableResult
    public func contents(@CellBuilder _ sectionContents: () -> [CellRepresentation]) -> Self {
        contents = sectionContents()
        return self
    }
    
    @discardableResult
    public func contents(_ closure: (Section) -> Void) -> Self {
        closure(self)
        return self
    }
    
    @discardableResult
    public func append<Content: CellRepresentation>(_ content: Content) -> Content {
        contents.append(content)
        return content
    }
    
    @discardableResult
    public func didSelect(_ action: @escaping (UITableView, IndexPath, Any?) -> Void) -> Self {
        selectedAction = action
        return self
    }
}
