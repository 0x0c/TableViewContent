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
                DefaultCellContent(title: "title", style: .subtitle).configure { (content) in
                    content.detailText = "subtitle"
                },
                DefaultCellContent(title: "title", style: .value1).configure { (content) in
                    content.detailText = "value1"
                    content.selectionStyle = .none
                },
                DefaultCellContent(title: "title", style: .value2).configure { (content) in
                    content.accessoryType = .disclosureIndicator
                    content.detailText = "value2"
                    }.didSelect { (_, _, _) in
                        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
                        self.navigationController?.pushViewController(viewController, animated: true)
                }]),
            TableViewSection(headerTitle: "header", contents: [
                SwitchCellContent(title: "Switch"),
                SwitchCellContent(title: "Switch2", isOn: true).toggle { (isOn) in
                    print("\(isOn)")
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
