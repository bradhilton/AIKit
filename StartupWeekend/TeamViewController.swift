//
//  TeamViewController.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(with team: Team) {
        nameLabel.text = team.name
        descriptionLabel.text = team.cellDescription
    }
    
}

class TeamViewController: UITableViewController {
    
    var teams: [Team] = [.aiKit, .curbAppeal, .givv, .mayday]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teams"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell
        cell.configure(with: teams[indexPath.row])
        return cell
    }
}


