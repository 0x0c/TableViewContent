//
//  SectionSupplementalyView.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2020/11/25.
//

import UIKit

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
