//
//  SeoulPlaceCollectionViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 17..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulPlaceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeView.dropShadow(color: #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1), opacity: 3, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        
    }
}
