//
//  SectionSupplementalyView.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

public enum SectionSupplementalyView: Hashable {
    public static func == (lhs: SectionSupplementalyView, rhs: SectionSupplementalyView) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case let .title(string):
            hasher.combine(string)
        case let .nib(uINib, any):
            hasher.combine(uINib)
            hasher.combine(any)
        case let .view(view, any):
            hasher.combine(view)
            hasher.combine(any)
        }
    }

    case title(String)
    case nib(UINib, AnyHashable)
    case view(UIView & SectionConfigurable, AnyHashable)

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
