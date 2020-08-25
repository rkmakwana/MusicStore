//
//  Error.swift
//  MusicStoreTests
//
//  Created by Rashmikant Makwana on 26/08/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import Foundation

class CustomError: LocalizedError, CustomStringConvertible {

   let desc: String

   init(str: String) {
      desc = str
   }

   var description: String {
      let format = NSLocalizedString("%@", comment: "Error description")
      return String.localizedStringWithFormat(format, desc)
   }
}

extension LocalizedError where Self: CustomStringConvertible {

   var errorDescription: String? {
      return description
   }
}
