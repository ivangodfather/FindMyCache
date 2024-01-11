//
//  User.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 10/1/24.
//

import Foundation

struct User: Decodable {
  let id: Int
  let username: String
  let email: String
  let appleAuth: AppleAuth?
}

extension User {
  static let mock = Self(
    id: 1,
    username: "ivanruiz",
    email: "godfatherobi@hotmail.com", 
    appleAuth: nil
  )
}

extension User {
  struct AppleAuth: Codable {
    let appleIdentifier: String
    let appleIdentityToken: String?
    let appleAuthorizationCode: String?
    let realUserStatus: String
  }
}
