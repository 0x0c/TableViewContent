//
//  ViewController.swift
//  TableViewContent
//
//  Created by Akira Matsuda on 10/08/2018.
//  Copyright (c) 2018 Akira Matsuda. All rights reserved.
//

import UIKit
import TableViewContent

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegate: ContentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dataSource = ContentDataSource([
            TableViewSection([
                DefaultCellContent(title: "title"),
                DefaultCellContent(title: "title", style: .subtitle)
                    .detailText("subtitle"),
                DefaultCellContent(title: "title", style: .value1)
                    .detailText("value1")
                    .selectionStyle(.none),
                DefaultCellContent(title: "title", style: .value2)
                    .accessoryType(.disclosureIndicator)
                    .detailText("value2")
                    .didSelect { (_, _, _) in
                        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
                        self.navigationController?.pushViewController(viewController, animated: true)
                }]),
            TableViewSection(headerTitle: "header", contents: [
                SwitchCellContent(title: "Switch")
                    .selectionStyle(.none),
                SwitchCellContent(title: "Switch2", isOn: true)
                    .toggle { (isOn) in
                        print("\(isOn)")
                    }.didSelect { (_, _, isOn) in
                        print("\(String(describing: isOn))")
                }]),
            TableViewSection(contents: [
                DefaultCellContent(title: "title")
                ], footerTitle: "footer"),
            TableViewSection(headerTitle: "header2", contents: [
                CustomCellContent().didButtonPress {
                    print("button pressed")
                }], footerTitle: "footer2"),
            TableViewSection().header("header3")
                .contents { (section) in
                    for i in 0...10 {
                        section.append(DefaultCellContent(title: "\(i)"))
                    }
                }.footer("footer3")
                .didSelected({ (_, index, _) in
                    print("selected \(index)")
                })
            ])
        tableView.dataSource = dataSource
        
        delegate = ContentDelegate(dataSource: dataSource)
        tableView.delegate = delegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
