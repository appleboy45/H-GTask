//
//  ImageCaching.swift
//  H&Glow
//
//  Created by Vineet Tomar on 21/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import Foundation
import UIKit

class ImageCaching: NSObject{
    
    //caching
    static var imageCache = NSCache<NSString, UIImage>()
    
    @objc static public func loadImage(url: String, imageView: UIImageView){
        
        if let cachedImage = ImageCaching.imageCache.object(forKey: url as NSString) {
            
            imageView.image = cachedImage
            
        }else{
            
            if imageView.image == nil{
                
                imageView.image = UIImage(named: "placeholder")
                
                DispatchQueue.main.async {
                    Utility.downloadImageFrom(urlString: url, completion: { (data) in
                        if let data = data {
                            guard let image: UIImage = UIImage(data: data)else{return}
                            DispatchQueue.main.async {
                                imageView.image = image
                                ImageCaching.imageCache.setObject(image, forKey: url as NSString)
                            }
                        }
                    })
                }
            }
        }
        
    }
    
    
}
