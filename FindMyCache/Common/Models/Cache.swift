//
//  Cache.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import Foundation
import MapKit

struct Cache: Identifiable {
  let id: String
  let name: String
  let latitude: Double
  let longitude: Double
  let createdAt: Date
  let userId: String
  
  var coordinate: CLLocationCoordinate2D {
    .init(latitude: latitude, longitude: longitude)
  }
  
  var systemImage: String {
    switch latitude {
    case -90..<(-30): return "theatermasks"
    case -30..<0: return "puzzlepiece.extension"
    case 0..<52: return "dice"
    default:
      return "suitcase"
    }
  }
}

extension Array where Element == Cache {
  static let mock = [
    Cache.mock1, .mock2, .mock3, .mock4, .mock5, .mock6, .mock7, .mock8, .mock9, .mock10,
    .mock11, .mock12, .mock13, .mock14, .mock15, .mock16, .mock17, .mock18, .mock19, .mock20,
    .mock21, .mock22, .mock23, .mock24, .mock25
  ]
}

extension Cache {
  static let mock1 = Cache(id: "1", name: "Cache1", latitude: 40.7128, longitude: -74.0060, createdAt: Date(), userId: "User1")
  static let mock2 = Cache(id: "2", name: "Cache2", latitude: 34.0522, longitude: -118.2437, createdAt: Date(), userId: "User2")
  static let mock3 = Cache(id: "3", name: "Cache3", latitude: 41.8781, longitude: -87.6298, createdAt: Date(), userId: "User3")
  static let mock4 = Cache(id: "4", name: "Cache4", latitude: 37.7749, longitude: -122.4194, createdAt: Date(), userId: "User4")
  static let mock5 = Cache(id: "5", name: "Cache5", latitude: 51.5074, longitude: -0.1278, createdAt: Date(), userId: "User5")
  static let mock6 = Cache(id: "6", name: "Cache6", latitude: 48.8566, longitude: 2.3522, createdAt: Date(), userId: "User6")
  static let mock7 = Cache(id: "7", name: "Cache7", latitude: 35.6895, longitude: 139.6917, createdAt: Date(), userId: "User7")
  static let mock8 = Cache(id: "8", name: "Cache8", latitude: -33.8688, longitude: 151.2093, createdAt: Date(), userId: "User8")
  static let mock9 = Cache(id: "9", name: "Cache9", latitude: -23.5505, longitude: -46.6333, createdAt: Date(), userId: "User9")
  static let mock10 = Cache(id: "10", name: "Cache10", latitude: 55.7558, longitude: 37.6173, createdAt: Date(), userId: "User10")
  static let mock11 = Cache(id: "11", name: "Cache11", latitude: 39.9042, longitude: 116.4074, createdAt: Date(), userId: "User11")
  static let mock12 = Cache(id: "12", name: "Cache12", latitude: 55.6761, longitude: 12.5683, createdAt: Date(), userId: "User12")
  static let mock13 = Cache(id: "13", name: "Cache13", latitude: 59.3293, longitude: 18.0686, createdAt: Date(), userId: "User13")
  static let mock14 = Cache(id: "14", name: "Cache14", latitude: 52.3676, longitude: 4.9041, createdAt: Date(), userId: "User14")
  static let mock15 = Cache(id: "15", name: "Cache15", latitude: 28.6139, longitude: 77.2090, createdAt: Date(), userId: "User15")
  static let mock16 = Cache(id: "16", name: "Cache16", latitude: -34.6037, longitude: -58.3816, createdAt: Date(), userId: "User16")
  static let mock17 = Cache(id: "17", name: "Cache17", latitude: 19.4326, longitude: -99.1332, createdAt: Date(), userId: "User17")
  static let mock18 = Cache(id: "18", name: "Cache18", latitude: -22.9068, longitude: -43.1729, createdAt: Date(), userId: "User18")
  static let mock19 = Cache(id: "19", name: "Cache19", latitude: 30.0333, longitude: 31.2333, createdAt: Date(), userId: "User19")
  static let mock20 = Cache(id: "20", name: "Cache20", latitude: -26.2041, longitude: 28.0473, createdAt: Date(), userId: "User20")
  static let mock21 = Cache(id: "21", name: "Cache21", latitude: 14.5995, longitude: 120.9842, createdAt: Date(), userId: "User21")
  static let mock22 = Cache(id: "22", name: "Cache22", latitude: 35.6895, longitude: 139.6917, createdAt: Date(), userId: "User22")
  static let mock23 = Cache(id: "23", name: "Cache23", latitude: 1.3521, longitude: 103.8198, createdAt: Date(), userId: "User23")
  static let mock24 = Cache(id: "24", name: "Cache24", latitude: 3.1390, longitude: 101.6869, createdAt: Date(), userId: "User24")
  static let mock25 = Cache(id: "25", name: "Cache25", latitude: 6.5244, longitude: 3.3792, createdAt: Date(), userId: "User25")
}
