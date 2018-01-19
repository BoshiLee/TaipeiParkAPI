//
//  NearestLandmarksView.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 19/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

class NearestLandmarksCollectionViewCell: UICollectionViewCell {
    var lamarkDetail: LandmarkDetail? {
        didSet{
            self.updateUI()
        }
    }
    
    @IBOutlet weak var landmarkImageView: WebImageView! {
        didSet{
            self.landmarkImageView.layer.cornerRadius = 40
            self.landmarkImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var landmarkName: UILabel!

    
    func updateUI() {
        self.landmarkName.text = self.lamarkDetail?.name
        
        if let imgURL = lamarkDetail?.imageURL {
            self.landmarkImageView.load(url: imgURL)
        }else {
            self.landmarkImageView.image = UIImage(named: "park")
        }
    }
}
