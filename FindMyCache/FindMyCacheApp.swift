//
//  FindMyCacheApp.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 4/1/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct FindMyCacheApp: App {
  let store: StoreOf<AppFeature> = Store(initialState: AppFeature.State()) {
    AppFeature()
  }
  var body: some Scene {
    WindowGroup {
      AppView(store: store)
    }
  }
}
