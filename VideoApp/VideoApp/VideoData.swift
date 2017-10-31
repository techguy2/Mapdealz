//
//  VideoData.swift
//  VideoApp
//
//  Created by Soeb on 1/30/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

class VideoData: NSObject {

    var thumbnailImagName: String?
    var title : String?
    
    var channel:Channel?
    
    static func callApi(){
        let urlString = "https://api.themoviedb.org/3/tv/popular?api_key=c9f685290de91b4917f1ce89817faca0"
        
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
                print(json!)
                
            
                
            }
            catch let err {
                print(err)
            }
            
        }
        task.resume()
      
}

}
