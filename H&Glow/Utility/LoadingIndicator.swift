//
//  LoadingIndicator.swift
//  H&Glow
//
//  Created by Vineet Tomar on 21/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import Foundation
import UIKit

class LoadingIndicator: UIView {
    
    /// ActivityIndicator
    let loader = UIActivityIndicatorView()
    
    /// Shared Instance
    static let shared: LoadingIndicator = {
        let instance = LoadingIndicator()
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepared()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Design Indicator and Adding subView to Window
    func prepared() {
        
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.frame = UIApplication.shared.windows.first!.frame
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        loader.frame = self.frame
        loader.style = .whiteLarge
        loader.center = self.center
        loader.color = UIColor.white
        self.addSubview(loader)
        
    }
    
    /// Show Indicator View with animation
    func show() {
        
        
        let application = UIApplication.shared.delegate as! AppDelegate
        // application.window?.rootViewController?.view.addSubview(self)
        
        DispatchQueue.main.async {
            application.window?.addSubview(self)
            
            self.loader.startAnimating()
            
            self.loader.bringSubviewToFront((application.window?.rootViewController?.view)!)
            // UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    /// Hide Indicator View with animation
    func hide() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
            self.loader.stopAnimating()
        }
        
        
        // if UIApplication.shared.isIgnoringInteractionEvents {
        // UIApplication.shared.endIgnoringInteractionEvents()
        // }
    }
    
}
