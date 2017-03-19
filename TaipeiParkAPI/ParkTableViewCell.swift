//
//  ParkTableViewCell.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 16/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

class ParkTableViewCell: UITableViewCell {
    
    
    var landmark: LandmarkDetail?  {
        didSet{
            self.updateUI()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var parkImageView: UIImageView! {
        didSet {
            self.parkImageView.clipsToBounds = true
            self.parkImageView.layer.cornerRadius = 40
        }
    }
    @IBOutlet weak var introductionField: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateUI(){
        // clear cell's information
        self.nameLabel.text = nil
        self.parkImageView.image = nil
        self.introductionField.attributedText = nil
        self.openTimeLabel.text = nil
        
        // insert informations to cell
        self.nameLabel.text = "\(self.landmark!.parkName) - \(self.landmark!.name)"
        self.introductionField.text = self.landmark?.introduction
        self.openTimeLabel.text = self.landmark?.openTime
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
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
