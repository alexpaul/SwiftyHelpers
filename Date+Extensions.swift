//
//  Date+Extensions.swift
//
//  Created by Alex Paul on 1/30/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//
import Foundation

extension Date {
  // get an ISO timestamp
  static func getISOTimestamp() -> String {
    let isoDateFormatter = ISO8601DateFormatter()
    let timestamp = isoDateFormatter.string(from: Date())
    return timestamp
  }
}
