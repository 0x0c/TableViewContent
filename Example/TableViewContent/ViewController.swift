//
//  ViewController.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 10/08/2018.
//  Copyright (c) 2018 Akira Matsuda. All rights reserved.
//

import TableViewContent
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var delegate: Delegate?

    private var textField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Example"
        let dataSource = DataSource {
            basicSection()
            configureSection()
            switchSection()
            customCellSection()
            viewHeaderSection()
            nibHeaderSection()
            multipleSelectionSection()
            exclusiveSelectionSection()
        }
        appendSection(dataSource)
        dataSource.presentSectinIndex = true
        delegate = Delegate(dataSource: dataSource, tableView: tableView)
        delegate?.clearSelectionAutomatically = true
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }

    func basicSection() -> Section {
        return Section {
            DefaultRow(title: "title")
            DefaultRow(title: "title", style: .subtitle)
                .detailText("subtitle")
            DefaultRow(title: "title", style: .value1)
                .detailText("value1")
                .updateAfterSelected(true)
                .didSelect { _, _, row in
                    row.configuration.title = "updated"
                }
            DefaultRow(title: "title", style: .value2)
                .accessoryType(.disclosureIndicator)
                .detailText("value2")
                .didSelect { _, _, _ in
                    let viewController = UIStoryboard(
                        name: "Main",
                        bundle: nil
                    ).instantiateViewController(withIdentifier: "ViewController")
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            DefaultRow(title: "Swipe")
                .trailingSwipeActions { () -> UISwipeActionsConfiguration? in
                    let action = UIContextualAction(
                        style: .destructive,
                        title: "trailing"
                    ) { _, _, handler in
                        print("trailing action")
                        handler(true)
                    }
                    let configuration = UISwipeActionsConfiguration(actions: [action])
                    configuration.performsFirstActionWithFullSwipe = true
                    return configuration
                }
                .leadingSwipeActions { () -> UISwipeActionsConfiguration? in
                    let action = UIContextualAction(
                        style: .destructive,
                        title: "leading"
                    ) { _, _, handler in
                        print("leading action")
                        handler(true)
                    }
                    action.backgroundColor = .blue
                    let configuration = UISwipeActionsConfiguration(actions: [action])
                    configuration.performsFirstActionWithFullSwipe = true
                    return configuration
                }
        }
        .sectionIndexTitle("Section")
    }

    func configureSection() -> Section {
        return Section {
            DefaultRow(title: "configure", reuseIdentifier: "configure cell")
                .bind { [unowned self] row in
                    if let textField = self.textField {
                        row.configuration.title = textField.text
                    }
                }
                .configure { cell, _, _ in
                    cell.backgroundColor = .red
                }
                .didSelect { [unowned self] tableView, indexPath, _ in
                    let alert = UIAlertController(title: "Please input text", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { _ in
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                    alert.addTextField { [unowned self] textField in
                        self.textField = textField
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
        }
    }

    func switchSection() -> Section {
        return Section {
            SwitchRow(title: "Switch")
                .toggled { isOn in
                    print("Switch1 \(isOn)")
                }
            SwitchRow(title: "Switch2", isOn: true)
                .toggled { isOn in
                    print("Switch2 \(isOn)")
                }
                .didSelect { _, _, row in
                    if let row = row as? SwitchRow {
                        row.isOn.toggle()
                    }
                }
                .updateAfterSelected(true)
        }
        .sectionIndexTitle("Switch Section")
    }

    func customCellSection() -> Section {
        return Section {
            CustomRow {
                print("button pressed")
            }
        }
        .sectionIndexTitle("Button Section")
    }

    func viewHeaderSection() -> Section {
        return Section()
            .header(.view(ColorHeaderView(height: 10), UIColor.green))
            .rows {
                DefaultRow(title: "a")
                DefaultRow(title: "b")
                DefaultRow(title: "c")
            }
            .footer(.view(ColorHeaderView(height: 10), UIColor.blue))
            .sectionIndexTitle("Header Section2")
    }

    func nibHeaderSection() -> Section {
        return Section()
            .header(.nib(UINib(nibName: "CustomHeaderView", bundle: nil), "custom header"))
            .rows {
                DefaultRow(title: "a")
                DefaultRow(title: "b")
                DefaultRow(title: "c")
            }
            .footer(.nib(UINib(nibName: "CustomHeaderView", bundle: nil), "custom footer"))
            .sectionIndexTitle("Custom Header Section")
    }

    func multipleSelectionSection() -> Section {
        return SelectionSection()
            .header(.title("Multiple Selection"))
            .rows {
                CheckmarkRow(title: "1")
                CheckmarkRow(title: "2")
                CheckmarkRow(title: "3")
            }
    }

    func exclusiveSelectionSection() -> Section {
        return SelectionSection(exclusive: true, destructive: true)
            .header(.title("Exclusive"))
            .rows {
                CheckmarkRow(title: "1")
                CheckmarkRow(title: "2")
                CheckmarkRow(title: "3")
            }
    }

    func appendSection(_ dataSource: DataSource) {
        dataSource.sections { dataSource in
            dataSource.append(
                Section()
                    .header(.title("header"))
                    .rows { section in
                        section.append(contentsOf: (0 ... 5).map { idx in
                            DefaultRow(title: "\(idx)")
                        })
                    }
                    .footer(.title("footer"))
                    .sectionIndexTitle("Header Section")
            )
        }
    }
}
