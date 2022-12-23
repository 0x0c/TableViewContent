//
//  DiffableDataSource.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2022/12/13.
//

import UIKit

@resultBuilder
public enum SectionableBuilder {
    public static func buildBlock(_ items: any Sectionable...) -> [any Sectionable] {
        items
    }
}

open class DiffableDataSource: UITableViewDiffableDataSource<AnyHashable, AnyHashable>, SectionProvider {
    public private(set) var sections: [any Sectionable] = []
    open var presentSectinIndex = false
    open var ignoreEmptySection = false
    public var selectedAction: ((UITableView, IndexPath) -> Void)?

    @discardableResult
    open func didSelect(_ action: @escaping (UITableView, IndexPath) -> Void) -> Self {
        selectedAction = { tableView, indexPath in
            action(tableView, indexPath)
        }
        return self
    }

    @discardableResult
    public func section(@SectionBuilder _ sectionContents: () -> [any Sectionable]) -> Self {
        sections = sectionContents()
        reload()
        return self
    }

    @discardableResult
    public func section(_ section: any Sectionable) -> Self {
        sections = [section]
        reload()
        return self
    }

    @discardableResult
    public func append(@SectionableBuilder _ sectionContents: () -> [any Sectionable]) -> Self {
        sections.append(contentsOf: sectionContents())
        reload()
        return self
    }

    @discardableResult
    public func append(_ section: any Sectionable) -> Self {
        sections.append(section)
        reload()
        return self
    }

    @discardableResult
    public func append(_ sections: [any Sectionable]) -> Self {
        self.sections.append(contentsOf: sections)
        reload()
        return self
    }

    public func reload() {
        var snapshot = NSDiffableDataSourceSnapshot<AnyHashable, AnyHashable>()
        for section in sections {
            if section.rows.isEmpty {
                if ignoreEmptySection == false {
                    snapshot.appendSections([section.snapshotSection])
                    snapshot.appendItems(section.snapshotItems, toSection: section.snapshotSection)
                }
            }
            else {
                snapshot.appendSections([section.snapshotSection])
                snapshot.appendItems(section.snapshotItems, toSection: section.snapshotSection)
            }
        }
        apply(snapshot, animatingDifferences: defaultRowAnimation != .none)
    }

    public func reloadSections(_ sections: [AnyHashable]) {
        var snapshot = snapshot()
        snapshot.reloadSections(sections)
        apply(snapshot, animatingDifferences: defaultRowAnimation != .none)
    }

    public func reloadItem(_ items: [AnyHashable]) {
        var snapshot = snapshot()
        snapshot.reloadItems(items)
        apply(snapshot, animatingDifferences: defaultRowAnimation != .none)
    }

    // MARK: -

    override public func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        let s = sections[section]
        switch s.headerView {
        case let .title(text):
            return text
        default:
            return nil
        }
    }

    override public func tableView(_: UITableView, titleForFooterInSection section: Int) -> String? {
        let s = sections[section]
        switch s.footerView {
        case let .title(text):
            return text
        default:
            return nil
        }
    }

    override public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if presentSectinIndex {
            var indexTitles = [String]()
            for section in sections {
                if let title = section.sectionIndexTitle {
                    indexTitles.append(title)
                }
                else {
                    return nil
                }
            }
            return indexTitles
        }
        return nil
    }
}
