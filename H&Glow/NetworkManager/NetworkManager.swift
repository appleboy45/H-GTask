//
//  APIManager.swift
//  H&Glow
//
//  Created by Vineet Tomar on 20/12/19.
//  Copyright © 2019 Gaurav Chopra. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject{
    
    let baseURL = "https://staging.healthandglow.com/api/catalog/product/v6/106,999/533953?app=web&version=3.0.0&shop=false"
    
    static let sharedInstance = NetworkManager()
    
    func loadData(withCompletion completion: @escaping (ResponseDataModel?, Error?) -> Void) {
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
           
            
            if error != nil{
                
                 print(error?.localizedDescription)
                
                completion(nil,error)
            }
            
            if let response = response{
                
                 print(response)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    if let message = json["message"] as? String{
                        if message == "Success"{
                            if let data2 = json["data"] as? [String:Any]{
                                let jsonData = try? JSONSerialization.data(withJSONObject: data2, options: .prettyPrinted)
                                print(jsonData)
                                let responseModel = try? JSONDecoder().decode(ResponseDataModel.self, from: jsonData as! Data)
                                print(responseModel)
                                completion(responseModel, nil)
                            }
                        }
                    }
                    
                    
                } catch {
                    print("error")
                }
            }
            
            
        })
        
        task.resume()
    }
    
    
}
