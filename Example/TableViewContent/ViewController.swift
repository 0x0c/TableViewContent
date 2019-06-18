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
        let section = TableViewSection([
            DefaultCellContent(title: "title"),
            DefaultCellContent(title: "title", style: .subtitle).configure { (content) in
                content.detailText = "subtitle"
            }])
        section.append(DefaultCellContent(title: "title", style: .value1).configure { (content) in
            content.detailText = "value1"
            content.selectionStyle = .none
        })
        section.append(DefaultCellContent(title: "title", style: .value2).configure { (content) in
            content.accessoryType = .disclosureIndicator
            content.detailText = "value2"
        }).selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        }

        
        let dataSource = ContentDataSource(sections:
            [section,
             TableViewSection(headerTitle: "header", contents: [
                SwitchCellContent(title: "Switch"),
                SwitchCellContent(title: "Switch2", isOn: true).toggleAction { (isOn) in
                    print("\(isOn)")
                }]),
             TableViewSection(headerTitle: "header2", footerTitle: "footer2", contents: [
                CellContent(nib: UINib(nibName: "CustomTableViewCell", bundle: nil), cellType: CustomTableViewCell.self, reuseIdentifier: "CustomTableViewCell"),
                CustomCellContent()
                ])
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
