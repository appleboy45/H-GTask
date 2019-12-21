//
//  ProductImageCVC.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import UIKit

class ProductImageCVC: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    
    var imageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(){
        
        guard let imageUrl = imageUrl else{return}
        
        ImageCaching.loadImage(url: imageUrl, imageView: productImage)
        
    }

}
