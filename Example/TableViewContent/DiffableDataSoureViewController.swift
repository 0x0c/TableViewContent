//
//  DiffableDataSoureViewController.swift
//  TableViewContent_Example
//
//  Created by Akira Matsuda on 2022/12/13.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import TableViewContent
import UIKit

class DiffableDataSoureViewController: UIViewController {
    var tableView: UITableView!
    var delegate: Delegate?
    var dataSource: DiffableDataSource!
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Diffable"

        tableView = UITableView(frame: .zero, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        dataSource = DiffableDataSource(
            tableView: tableView,
            cellProvider: { [unowned self] _, indexPath, _ in
                return cell(for: indexPath)
            }
        )
        tableView.dataSource = dataSource
        dataSource.append(Section {
            DefaultRow(title: "title")
            DefaultRow(title: "title", style: .subtitle)
                .detailText("subtitle")
            DefaultRow(title: "title", style: .value1)
                .detailText("value1")
                .updateAfterSelected(true)
                .didSelect { _, _, row in
                    row.configuration.title = "updated"
                }
        })
        delegate = Delegate(dataSource: dataSource, tableView: tableView)
        delegate?.clearSelectionAutomatically = true
        tableView.delegate = delegate
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    open func cell(for indexPath: IndexPath) -> UITableViewCell? {
        let section = dataSource.section(for: indexPath.section)
        guard let cell = section.cell(tableView, indexPath: indexPath) else {
            return nil
        }
        configureCell(cell)
        return cell
    }

    open func configureCell(_ cell: UITableViewCell) {}

    @objc
    func refresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dataSource.sections {
                Section([
                    DefaultRow(title: "title"),
                    DefaultRow(title: "title"),
                    DefaultRow(title: "title", style: .subtitle)
                        .detailText("subtitle"),
                    DefaultRow(title: "title", style: .value1)
                        .detailText("value1")
                ].shuffled)
            }
            sender.endRefreshing()
        }
    }
}
