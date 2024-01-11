//
//  Data+.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 11/1/24.
//

import Foundation

extension Optional where Wrapped == Data {
  var utf8: String? {
    if let data = self {
      return String(data: data, encoding: .utf8)
    }
    return nil
  }
}
