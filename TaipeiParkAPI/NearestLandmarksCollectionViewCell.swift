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
    
    @IBOutlet weak var landmarkImageView: UIImageView! {
        didSet{
            self.landmarkImageView.layer.cornerRadius = 40
            self.landmarkImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var landmarkName: UILabel!

    
    func updateUI() {
        self.landmarkName.text = self.lamarkDetail?.name
        
        if let imgURL = lamarkDetail?.imageURL {
            if let imageData = try? Data(contentsOf: imgURL) {
                DispatchQueue.main.async { [weak weakSelf = self] in
                    // blocks main thread!
                    weakSelf?.landmarkImageView.image = UIImage(data: imageData as Data)
                }
            }
        }else {
            self.landmarkImageView.image = UIImage(named: "park")
        }
    }
}
