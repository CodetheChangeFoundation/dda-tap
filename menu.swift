//
//  menu.swift
//  dda-tap
//
//  Created by Victor Sira on 2019-10-27.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit
import TAPKit

class menu: UITableViewController {
    
    // MARK: Properties
    
    var menuLabels = ["Add picture and recording", "Instructions", "TAP guide"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuLabels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MenuCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MenuOption
            else {
                fatalError("The dequeued cell is not an instance of MenuOption.")
        }
        
        // Fetches the appropriate menuOption for the data source layout
        let label = menuLabels[indexPath.row]
        cell.nameLabel.text = label
        
        return cell
    }
    
    // MARK: Private Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier: String
        switch indexPath.row {
        case 0:
             segueIdentifier = "showAddMainEntries"
        case 1:
             segueIdentifier = "showInstructions"
        case 2:
            segueIdentifier = "showTAPGuide"
        default:
             segueIdentifier = "showAddMainEntries"
        }
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
}
