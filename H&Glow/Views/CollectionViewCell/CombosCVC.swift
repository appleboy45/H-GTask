//
//  CombosCVC.swift
//  H&Glow
//
//  Created by Vineet Singh on 21/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import UIKit

class CombosCVC: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    //Product1
    @IBOutlet weak var prod1Img: UIImageView!
    @IBOutlet weak var prod1Name: UILabel!
    @IBOutlet weak var prod1Price: UILabel!
    
    //Product2
    @IBOutlet weak var prod2Img: UIImageView!
    @IBOutlet weak var prod2Name: UILabel!
    @IBOutlet weak var prod2Price: UILabel!
    
    @IBOutlet weak var comboDiscountPrice: UILabel!
    @IBOutlet weak var comboPrice: UILabel!
    
    @IBOutlet weak var buyComboBtn: UIButton!
    
    var combo: ProductCombo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buyComboBtn.layer.borderWidth = 1
        buyComboBtn.layer.borderColor = UIColor.orange.cgColor
        
        parentView.layer.borderWidth = 0.5
        parentView.layer.borderColor = UIColor.gray.cgColor
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Your Text")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
    }

    func setupCell(){
        
        guard let combo = combo else{return}
        
        if let listprice = combo.listPrice{
            comboDiscountPrice.text = "₹\(listprice)"
        }
        
        if let defaultPrice = combo.defaultPrice{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(defaultPrice)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            comboPrice.attributedText = attributeString
        }
        
        //Sku1
        guard let sku1 = combo.sku1 else{return}
        
        if let title = sku1.skuName{
            prod1Name.text = title
        }
        
        if let price = sku1.defaultPrice{
            prod1Price.text = "₹\(price)"
        }
        
        guard let imageUrl = sku1.skuImageUrl else{return}
        
        ImageCaching.loadImage(url: imageUrl, imageView: prod1Img)
        
        
        //Sku2
        guard let sku2 = combo.sku2 else{return}
        
        if let title = sku2.skuName{
            prod2Name.text = title
        }
        
        if let price = sku2.defaultPrice{
            prod2Price.text = "₹\(price)"
        }
        
        guard let imageUrl2 = sku2.skuImageUrl else{return}
        
        ImageCaching.loadImage(url: imageUrl2, imageView: prod2Img)
        
    }
    
}
