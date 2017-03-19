//
//  ParkTableViewController.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 16/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

class ParkTableViewController: UITableViewController {
    let apiManager = ApiManager.shared
    var parks = Parks() {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = tableView.rowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        let data = apiManager.apiData
        apiManager.praseJson(from: data, errorHandeler: { $0.handler()}) {
            self.parks = $0
        }
    }

}

extension ParkTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.parks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.parks[section].parkName
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.parks[section].landmarks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.RuesedIdentifier.tableView.rawValue, for: indexPath)
        // Configure the cell...
        if let parkCell = cell as? ParkTableViewCell {
            parkCell.landmark = self.parks[indexPath.section].landmarks[indexPath.row]
            return parkCell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainSB = UIStoryboard.main
        if let parkDeatilVC = mainSB.instantiateViewController(withIdentifier: StoryBoard.Main.parkDetail.rawValue) as? ParkDetailViewController {
            parkDeatilVC.indexPath = indexPath
            //parkDeatilVC.landmark = parks[indexPath.section].landmarks[indexPath.row]
            parkDeatilVC.parks = self.parks
            self.present(parkDeatilVC, animated: true, completion: nil)
        }
    }
}
