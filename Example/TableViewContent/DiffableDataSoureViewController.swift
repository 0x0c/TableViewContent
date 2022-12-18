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
    var dataSource: DiffableDataSource!
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
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
        dataSource.append(Section([
            DefaultRow(title: "title"),
            DefaultRow(title: "title"),
            DefaultRow(title: "title", style: .subtitle)
                .detailText("subtitle"),
            DefaultRow(title: "title", style: .value1)
                .detailText("value1")
        ].shuffled))
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

    open func registerViews(_ sections: [any Sectionable]) {
        for section in sections {
            section.registerCell(tableView: tableView)
        }
    }

    open func updateDataSource(_ sections: [any Sectionable], animateWhenUpdate: Bool = true) {
        registerViews(sections)
    }

    open func reloadSections() {
        updateDataSource(dataSource.sections)
    }

    open func didSelectRow(at indexPath: IndexPath) {}

    @objc
    func refresh(_ sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dataSource.section {
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

extension DiffableDataSoureViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(at: indexPath)
    }
}
