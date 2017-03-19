//
//  NearestLandmarkCollectionView.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 19/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

class NearestLandmarkCollectionView: UICollectionView {
    
    var parkEntity: ParkEntity! {
        didSet {
            self.dataSource = self
            self.delegate = self
            let nib = UINib(nibName: "NearestLandmarksCollectionViewCell", bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: StoryBoard.RuesedIdentifier.collectionView.rawValue)
            self.selfLayOut()
        }
    }
    
    func selfLayOut() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        self.showsHorizontalScrollIndicator = false
    }

}

extension NearestLandmarkCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parkEntity!.landmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.RuesedIdentifier.collectionView.rawValue, for: indexPath)
        if let landmarkCell = cell as? NearestLandmarksCollectionViewCell {
            landmarkCell.lamarkDetail = parkEntity!.landmarks[indexPath.row]
            return landmarkCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
