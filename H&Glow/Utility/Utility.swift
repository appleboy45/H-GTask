//
//  Utility.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject{
    
    @objc public static func alertView(controller: UIViewController,title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        controller.present(alert, animated: false, completion: nil)
        
    }
    
    @objc public static func downloadImageFrom(urlString:String, completion:@escaping(Data?)->()) {
        guard let url = URL(string:urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, err) in
            if err != nil {
                // handle error if any
            }
            if let data = data{
                guard let image: UIImage = UIImage(data: data)else{return}
                ImageCaching.imageCache.setObject(image, forKey: urlString as NSString)
            }
            // you should check the reponse status
            // if data is a json object/dictionary so decode it
            // if data is regular data then pass it to your callback
            completion(data)
            }.resume()
    }
    
    @objc public static func addShadow(view: UIView){
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        

    }
    
    public class func alertViewController(controller : UIViewController,title : String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action: UIAlertAction!) in
            
            
        }))
        
        controller.present(alert, animated: false, completion: nil)
        
    }
    
}


