//
//  CleanBeautyCVC.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import UIKit

class CleanBeautyCVC: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var cleanBeautyImage: UIImageView!
    
    var imageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(){
        
        guard let imageUrl = imageUrl else{return}
        
        ImageCaching.loadImage(url: imageUrl, imageView: cleanBeautyImage)
        
        
    }
    
    
}
