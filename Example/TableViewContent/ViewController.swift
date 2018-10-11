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
    let dataSource = ContentDataSource()
    var delegate: ContentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let section = TableViewSection()
        section.contents.append(DefaultCellContent(title: "title").selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
        })
        section.contents.append(DefaultCellContent(title: "title", style: .subtitle).selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
                content.detailText = "subtitle"
        })
        section.contents.append(DefaultCellContent(title: "title", style: .value1).selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
                content.detailText = "value1"
        })
        section.contents.append(DefaultCellContent(title: "title", style: .value2).selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
                content.detailText = "value2"
        })
        
        section.contents.append(DefaultCellContent(title: "title").selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
        })
        section.contents.append(DefaultCellContent(title: "title", style: .subtitle).selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
                content.detailText = "subtitle"
        })
        section.contents.append(DefaultCellContent(title: "title", style: .value1).selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
                content.detailText = "value1"
        })
        section.contents.append(DefaultCellContent(title: "title", style: .value2).selectedAction { (_, _, _) in
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
            }.contentConfiguration { (content) in
                content.accessoryType = .disclosureIndicator
                content.detailText = "value2"
        })
        
        let section2 = TableViewSection(headerTitle: "header")
        let switchRow = SwitchCellContent { (cell, indexPath, isOn) in
            cell.textLabel?.text = "Switch"
            cell.isSwitchOn = isOn
            }.toggleAction { (isOn) in
                print("\(isOn)")
        }
        section2.contents.append(switchRow)
        
        let section3 = TableViewSection(headerTitle: "header2", footerTitle: "footer2")

        let customRow = CellContent(nib: UINib(nibName: "CustomTableViewCell", bundle: nil), cellType: CustomTableViewCell.self, reuseIdentifier: "CustomTableViewCell", configuration: { (cell, indexPath, data) in
            cell.textLabel?.text = "CustomTableViewCell"
        })
        section3.contents.append(customRow)

        dataSource.sections = [section, section2, section3]
        tableView.dataSource = dataSource
        
        delegate = ContentDelegate(dataSource: dataSource)
        tableView.delegate = delegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
