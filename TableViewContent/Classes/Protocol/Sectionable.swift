//
//  Sectionable.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2022/12/14.
//

import Foundation

public protocol Sectionable: Hashable {
    var snapshotItems: [AnyHashable] { get }

    var selectedAction: ((UITableView, IndexPath) -> Void)? { get set }
    var updateAfterSelected: Bool { get set }
    var updateAnimation: UITableView.RowAnimation { get set }
    var rows: [any RowRepresentation] { get set }
    var headerView: SectionSupplementalyView? { get set }
    var footerView: SectionSupplementalyView? { get set }
    var sectionIndexTitle: String? { get set }

    func registerCell(tableView: UITableView)
    func cell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
}

public extension Sectionable {
    var snapshotItems: [AnyHashable] {
        return rows.map {
            AnyHashable($0)
        }
    }

    static func == (lhs: any Sectionable, rhs: any Sectionable) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(snapshotItems)
        hasher.combine(headerView)
        hasher.combine(footerView)
    }
}

var nonceKey: UInt8 = 0
public extension Sectionable {
    var nonce: String? {
        guard let associatedObject = objc_getAssociatedObject(
            self,
            &nonceKey
        ) as? String else {
            return nil
        }
        return associatedObject
    }

    var snapshotSection: AnyHashable {
        var hasher = Hasher()
        rows.forEach {
            hasher.combine($0)
        }
        hasher.combine(nonce)
        hasher.combine(hashValue)
        return hasher.finalize()
    }

    func makeUnique(nonce: String = UUID().uuidString) {
        objc_setAssociatedObject(
            self,
            &nonceKey,
            nonce,
            .OBJC_ASSOCIATION_RETAIN
        )
    }
}
