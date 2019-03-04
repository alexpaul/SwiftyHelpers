//
//  DownsamplingImage.swift
//
//  Created by Alex Paul on 3/4/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation
import ImageIO
import UIKit

final class DownsamplingImage {
  public static func downsampledImage(data: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
      return nil
    }
    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
    let downsampleOptions = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceShouldCacheImmediately: true,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
      return nil
    }
    return UIImage(cgImage: downsampledImage)
  }
}
