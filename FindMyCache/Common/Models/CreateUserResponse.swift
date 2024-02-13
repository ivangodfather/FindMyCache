//
//  CreateUserResponse.swift
//  FindMyCache
//
//  Created by Ivan Monjo on 8/2/24.
//

import Foundation

struct CreateUserResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let user: User
}

extension CreateUserResponse {
    static let mock = Self(
        accessToken: "1",
        refreshToken: "2",
        user: .mock
    )
}
