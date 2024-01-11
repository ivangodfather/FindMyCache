//
//   ASUserDetectionStatus+.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 10/1/24.
//

import AuthenticationServices

extension ASUserDetectionStatus: CustomStringConvertible {
  public var description: String {
    switch self {
    case .likelyReal: return "LIKELY_REAL"
    case .unknown: return "UNKNOWN"
    default: return "UNSUPPORTED"
    }
  }
}
