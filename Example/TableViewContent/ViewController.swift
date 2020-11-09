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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Example"
        let dataSource = DataSource {
            Section {
                DefaultRow(title: "title")
                DefaultRow(title: "title", style: .subtitle)
                    .detailText("subtitle")
                DefaultRow(title: "title", style: .value1)
                    .detailText("value1")
                    .updateAfterSelected(true)
                    .didSelect { _, _, configuration in
                        configuration.title = "updated"
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
            }
            Section {
                SwitchRow(title: "Switch")
                    .toggled { isOn in
                        print("Switch1 \(isOn)")
                    }
                SwitchRow(title: "Switch2", isOn: true)
                    .toggled { isOn in
                        print("Switch2 \(isOn)")
                    }
            }
            Section {
                CustomRow {
                    print("button pressed")
                }
            }
            Section()
                .header(.title("header"))
                .rows { section in
                    for i in 0 ... 5 {
                        section.append(DefaultRow(title: "\(i)"))
                    }
                }
                .footer(.title("footer"))
            Section()
                .header(.nib("custom header", UINib(nibName: "CustomHeaderView", bundle: nil)))
                .rows { section in
                    for i in 0 ... 5 {
                        section.append(DefaultRow(title: "\(i)"))
                    }
                }
                .footer(.nib("custom footer", UINib(nibName: "CustomHeaderView", bundle: nil)))
        }
        delegate = Delegate(dataSource: dataSource)
        delegate?.clearSelectionAutomatically = true
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
