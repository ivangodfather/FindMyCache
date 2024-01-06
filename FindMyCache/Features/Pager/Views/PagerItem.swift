//
//  PagerItem.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import Foundation

struct PagerItem: Identifiable, Hashable {
  let title: String
  let image: String
  let description: String
  
  var id: String { title }
}

// MARK: - Onboarding
extension Array where Element == PagerItem {
  static let onboarding = [
    PagerItem(
      title: "First",
      image: "globe.americas",
      description: "This is some random description"
    ),
    PagerItem(
      title: "Second",
      image: "globe.central.south.asia",
      description: "This is some random description1"
    ),
    PagerItem(
      title: "Third",
      image: "globe.europe.africa",
      description: "This is some random description "
    )
  ]
}





