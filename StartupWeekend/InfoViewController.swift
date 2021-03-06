//
//  InfoViewController.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/31/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit
import XTable

func logoSection() -> Section {
    return Section { section in
        section.rows = [ logoRow() ]
    }
}

func logoRow()-> Row {
    return Row { row in
        row.height = .automatic(estimated: 200)
        row.cell = Cell { (cell: StartupWeekendImageTableViewCell)  in }
    }
}


func startupWeekendSection() -> Section {
    return Section { section in
        section.rows = [ startupWeekendRow() ]
    }
}

func locationSection() -> Section {
    return Section { section in
        section.rows = [ locationRow() ]
    }
}

func locationRow()-> Row {
    return Row { row in
        row.height = .automatic(estimated: 200)
        row.cell = Cell { cell in
            cell.textLabel?.text = StartupWeekend().aiLocation
        }
    }
}

func datesSection() -> Section {
    return Section { section in
        section.rows = [ datesRow() ]
    }
}

func datesRow()-> Row {
    return Row { row in
        row.height = .automatic(estimated: 200)
        row.cell = Cell { cell in
            cell.textLabel?.text = StartupWeekend().dates
        }
    }
}

func startupWeekendRow()-> Row {
    return Row { row in
        row.height = .automatic(estimated: 200)
        row.cell = Cell { (cell: StartupWeekendTableViewCell) in }
    }
}

class StartupWeekendImageTableViewCell: UITableViewCell {}

class StartupWeekendTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with startupWeekend: StartupWeekend) {
        titleLabel.text = startupWeekend.name
        datesLabel.text = startupWeekend.dates
        locationLabel.text = startupWeekend.location
        descriptionLabel.text = startupWeekend.description
    }
}

class InfoViewController: UITableViewController {
    
    var startupWeekend = StartupWeekend()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "StartupWeekendTableViewCell", bundle: nil), forCellReuseIdentifier: "StartupWeekendTableViewCell")
        tableView.register(UINib(nibName: "StartupWeekendImageTableViewCell", bundle: nil), forCellReuseIdentifier: "StartupWeekendImageTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "StartupWeekendImageTableViewCell")!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StartupWeekendTableViewCell") as! StartupWeekendTableViewCell
            cell.configure(with: startupWeekend)
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.text = startupWeekend.location
            return cell
        case 3:
            let cell = UITableViewCell()
            cell.textLabel?.text = startupWeekend.description
            return cell
        default:
            return UITableViewCell()
        }
    }
}
