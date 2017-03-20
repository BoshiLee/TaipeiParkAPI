//
//  ParkDetailViewController.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 19/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit


class ParkDetailViewController: UIViewController {
    
    var landmark: LandmarkDetail?
    var parks: Parks? {
        didSet{
            if let path = indexPath {
                self.landmark = self.parks?[path.section].landmarks[path.row]
            }
        }
    }
    var indexPath: IndexPath?

    @IBOutlet weak var parkImageView: UIImageView!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var nearestLandmarkCollectionView: NearestLandmarkCollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nearestLandmarkCollectionView.frame.size.width = self.view.bounds.width
        upDataUI()
        // Do any additional setup after loading the view.
    }

    func upDataUI() {
        if let revceivedData = self.landmark
        {
  
            if let imgURL = landmark?.imageURL {
                if let imageData = try? Data(contentsOf: imgURL) {
                    DispatchQueue.main.async { [weak weakSelf = self] in
                        // blocks main thread!
                        weakSelf?.parkImageView.image = UIImage(data: imageData as Data)
                    }
                }
            }else {
                self.parkImageView.image = UIImage(named: "park")
            }
            self.parkNameLabel.text = revceivedData.parkName
            self.nameLabel.text = revceivedData.name
            self.openTimeLabel.text = revceivedData.openTime
            self.introductionLabel.text = revceivedData.introduction
            self.nearestLandmarkCollectionView.parkEntity = self.parks?[(indexPath?.section)!]
        }
        
    }
    @IBAction func dissmissView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}


