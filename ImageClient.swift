// updated to use Swift 5.0 Result type 

import UIKit

enum AppError: Error {
  case badStatusCode(Int)
  case clientError(Error)
  case badURL(String)
  case expectedMimeType(String)
}

struct ImageClient {
  static func fetchImage(for urlString: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
    guard let url = URL(string: urlString) else {
      completion(.failure(AppError.badURL(urlString)))
      return
    }
    let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(AppError.clientError(error)))
      }
      guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
          completion(.failure(AppError.badStatusCode(((response as? HTTPURLResponse)?.statusCode ?? -999))))
          return
      }
      if let mimeType = httpResponse.mimeType,
        mimeType == "image/jpeg",
        let data = data {
        let imageData = UIImage(data: data)
        
        // if we attempt to return imageData here we won't get the expected behaviour
        // the image is being processed asynchronously so the method would return before
        // the processing is complete
        // here we have to use an @escaping closure capture the data when it's finished proecessing
        completion(.success(imageData))
      } else {
        completion(.failure(AppError.expectedMimeType(httpResponse.mimeType ?? "no valid mimeType")))
      }
    }
    dataTask.resume()
  }
}
