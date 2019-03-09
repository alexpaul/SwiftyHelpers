//
//  IBDesignableViews.swift
//
//  Created by Alex Paul on 2/16/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

@IBDesignable
class CircularButton: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView?.contentMode = .scaleAspectFill
    layer.cornerRadius = bounds.width / 2.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.5
    clipsToBounds = true
  }
}

@IBDesignable
class CircularImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    contentMode = .scaleAspectFill
    layer.cornerRadius = bounds.width / 2.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.5
    clipsToBounds = true
  }
}

@IBDesignable
class CornerImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    contentMode = .scaleAspectFill
    layer.cornerRadius = 12.0
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.5
    clipsToBounds = true
  }
}
