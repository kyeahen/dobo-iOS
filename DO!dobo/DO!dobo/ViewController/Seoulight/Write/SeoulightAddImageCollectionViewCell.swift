//
//  SeoulightAddImageCollectionViewCell.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 21..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit

class SeoulightAddImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
}


