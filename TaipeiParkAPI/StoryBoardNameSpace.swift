//
//  StoryBoardDelegates.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 19/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

struct StoryBoard {
    enum Main: String{
        case parkDetail = "ParkDetailViewController"
    }
    
    enum RuesedIdentifier: String {
        case tableView = "ParkTableViewCell"
        case collectionView = "NearestLandmarkView"
    }
}

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
}
