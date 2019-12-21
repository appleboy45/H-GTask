//
//  VolumeCVC.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import UIKit

class VolumeCVC: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var volumeDesc: UILabel!
    
    var volumeData : Volume?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        parentView.layer.cornerRadius = 30
        parentView.layer.borderWidth = 1.0
        parentView.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    func setupCell(){
        
        guard let volume = volumeData else{return}
        
        if let volume = volume.volume{
            volumeDesc.text = volume
        }
        
        if let isSelected = volume.isSelected{
            if isSelected == true{
                parentView.backgroundColor = .orange
                volumeDesc.textColor = .white
            }
            else
            {
                parentView.backgroundColor = .white
                volumeDesc.textColor = .lightGray
            }
        }
        else{
            parentView.backgroundColor = .white
        }
        
    }

}
