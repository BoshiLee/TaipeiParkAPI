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
    
    var parkImage: UIImage? {
        get{
            return self.parkImageView.image
        }
        set{
            self.parkImageView.image = newValue
        }
    }
    
    // MARK: - Declartion
    var imageURL: URL? {
        didSet {
            self.parkImage = nil
            if self.parkImageView?.image == nil {
                fetchImage()
            }
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
        self.imageURL = landmark?.imageURL
    }
    
    private func fetchImage() {
        if let url = imageURL{
            DispatchQueue.global(qos: .userInitiated).async {
                let contentOfURL = NSData(contentsOf: url as URL)
                DispatchQueue.main.async { [weak self] in
                    if url == self?.imageURL {
                        if let imageData = contentOfURL{
                            self?.parkImage = UIImage(data: imageData as Data)
                        } else {
                        }
                    }else {
                        self?.parkImage = UIImage(named: "park")
                    }
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
