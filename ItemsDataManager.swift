//
//  ItemsDataManager.swift
//
//  Created by Alex Paul on 2/1/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

final class ItemsDataManager<T: Codable> where T: Equatable {
  private  var filename = "Documents.plist"

  // create
  public func saveItemToDocumentsDirectory(item: T) {
    let path = FileManagerHelper.filepathToDocumentsDirectory(filename: filename)
    var items = fetchItemsFromDocumentsDirectory()
    items.append(item)
    do {
      let data = try PropertyListEncoder().encode(items)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch {
      print("property list decoding error: \(error)")
    }
  }
  
  // read
  public func fetchItemsFromDocumentsDirectory() -> [T] {
    let path = FileManagerHelper.filepathToDocumentsDirectory(filename: filename).path
    var items = [T]()
    if FileManager.default.fileExists(atPath: path) {
      if let data = FileManager.default.contents(atPath: path) {
        do {
          items = try PropertyListDecoder().decode([T].self, from: data)
        } catch {
          print("property list decoding error: \(error)")
        }
      } else {
        print("data is nil")
      }
    } else {
      print("\(filename) does not exist")
    }
    return items
  }
  
  // update
  public func updateItem(item: T, atIndex index: Int) {
    let path = FileManagerHelper.filepathToDocumentsDirectory(filename: filename)
    var items = fetchItemsFromDocumentsDirectory()
    items[index] = item
    do {
      let data = try PropertyListEncoder().encode(items)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch {
      print("property list decoding error: \(error)")
    }
  }
  
  // delete
  public func deleteItem(atIndex index: Int, item: T) {
    let path = FileManagerHelper.filepathToDocumentsDirectory(filename: filename)
    var items = fetchItemsFromDocumentsDirectory()
    let index = items.index { $0 == item }
    if let foundIndex = index {
      items.remove(at: foundIndex)
    }
    do {
      let data = try PropertyListEncoder().encode(items)
      try data.write(to: path, options: Data.WritingOptions.atomic)
    } catch {
      print("property list decoding error: \(error)")
    }
  }
}
