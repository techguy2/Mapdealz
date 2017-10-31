//
//  Helper.swift
//  friends
//
//  Created by Soeb on 2/13/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit

extension UIColor{
    
    convenience init(red:CGFloat,green:CGFloat,blue:CGFloat) {
        
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCache = NSCache<NSString , UIImage>()

extension UIImageView {
    
    
    func loadImageUsingUrl(urlString: String) {
        self.image = nil
        // Check if image is present in cache
        if let cacheImage = imageCache.object(forKey: urlString as NSString){
            self.image = cacheImage
            return
        }
        
        
        // Download image since not present in cache
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            // Data is recieved if reach until this point
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                }
               
            }
            
            
        }
        .resume()
    }
}
