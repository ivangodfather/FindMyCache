//
//  Codable+.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 10/1/24.
//

import Foundation

extension Encodable {
    var encodeToJSON: Data? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return jsonData
    }
}
