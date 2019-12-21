//
//  FacetCVC.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import UIKit

class FacetCVC: UICollectionViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var facetTitle: UILabel!
    
    var facet: Facets?
    var facetIsSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(){
        
        guard let facet = facet else{return}
        
        if let title = facet.title{
            facetTitle.text = title
        }
        if facetIsSelected{
            facetTitle.textColor = .orange
        }
        else
        {
            facetTitle.textColor = .gray
        }
        
    }
    
}
