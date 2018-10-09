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
    let dataSource = TableViewContentDataSource()
    var delegate: TableViewContentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let section = TableViewSection()
        for i in 0...3 {
            let row = TableViewContent(title: "row \(i)")
            section.contents.append(row)
            row.action = { [unowned self] in
                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        let section2 = TableViewSection(headerTitle: "header")
        let switchRow = SwitchCellContent(title: "switch")
        section2.contents.append(switchRow)
        
        let section3 = TableViewSection(headerTitle: "header2", footerTitle: "footer2")
        let customRow = CustomCellContent(nib: UINib(nibName: "CustomTableViewCell", bundle: nil))
        section3.contents.append(customRow)
        
        dataSource.sections = [section, section2, section3]
        tableView.dataSource = dataSource
        
        delegate = TableViewContentDelegate(dataSource: dataSource)
        tableView.delegate = delegate
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    @objc func update() {
        tableView.refreshControl?.beginRefreshing()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}

