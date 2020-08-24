//
//  CachedImageView.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 21/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation
import UIKit

class CachedImageView: UIImageView {
    
    let imageCache = NSCache<NSString, AnyObject>()
    
    public func setImage(url: URL,
                         completion: @escaping ((_ success: Bool) -> ())) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
            completion(true)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                if let downloaded = UIImage(data: data) {
                    self?.imageCache.setObject(downloaded, forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self?.image = downloaded
                        completion(true)
                    }
                } else {
                    completion(false)
                }
                }.resume()
        }
    }
    
}
