//
//  JudgeViewController.swift
//  StartupWeekend
//
//  Created by Lorraine Alexander on 3/30/18.
//  Copyright © 2018 AIKit. All rights reserved.
//

import UIKit

class JudgeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with judge: Judge) {
        judgeImageView.image = judge.image
        bioLabel.text = judge.title
        nameLabel.text = judge.name
    }
}

class JudgeViewController: UITableViewController {

    var judges: [Judge] = [.john, .seth, .amy, .peter, .quinn]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Judges"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "JudgeTableViewCell", bundle: nil), forCellReuseIdentifier: "JudgeTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return judges.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JudgeTableViewCell") as! JudgeTableViewCell
        cell.configure(with: judges[indexPath.row])
        return cell
    }
}

