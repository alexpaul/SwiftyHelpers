//
//  ImageCache.swift
//
//  Created by Alex Paul on 2/8/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

final class ImageCache {
  private init() {}
  
  private static var cache = NSCache<NSString, UIImage>()
  
  static func fetchImageFromNetwork(urlString: String, completion: @escaping (AppError?, UIImage?) -> Void) {
    NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data ) in
      if let appError = appError {
        completion(appError, nil)
      } else if let data = data {
        DispatchQueue.global().async {
          if let image = UIImage(data: data) {
            cache.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
              completion(nil, image)
            }
          }
        }
      }
    }
  }
  
  static func fetchImageFromCache(urlString: String) -> UIImage? {
    return cache.object(forKey: urlString as NSString)
  }
}

// Example Use Case: 
/*
    if let image = ImageCache.fetchImageFromCache(urlString: photoURL.absoluteString) {
      profileImageButton.setImage(image, for: .normal)
    } else {
      ImageCache.fetchImageFromNetwork(urlString: photoURL.absoluteString) { (appError, image) in
        if let appError = appError {
          self.showAlert(title: "Fetching Image Error", message: appError.errorMessage())
        } else if let image = image {
          self.profileImageButton.setImage(image, for: .normal)
        }
      }
    }
*/
