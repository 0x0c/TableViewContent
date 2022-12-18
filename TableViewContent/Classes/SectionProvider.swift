//
//  SectionProvider.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 2022/12/13.
//

import Foundation

public protocol SectionProvider: AnyObject {
    var sections: [any Sectionable] { get }

    func section(for sectionIndex: Int) -> any Sectionable
}

public extension SectionProvider {
    func section(for sectionIndex: Int) -> any Sectionable {
        return sections[sectionIndex]
    }
}
