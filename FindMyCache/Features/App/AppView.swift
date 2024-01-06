//
//  AppView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 4/1/24.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
  var store: StoreOf<AppFeature>
  
  var body: some View {
    if let loginStore = store.scope(state: \.login, action: \.login) {
      LoginView(store: loginStore)
    } else if let mainTabStore = store.scope(state: \.mainTab, action: \.mainTab) {
      MainTabView(store: mainTabStore)
    } else {
      Text("Show login").onAppear {
        store.send(.onAppear)
      }
    }
  }
}

#Preview {
  AppView(
    store: .init(initialState: AppFeature.State()) {
      AppFeature()
    }
  )
}
