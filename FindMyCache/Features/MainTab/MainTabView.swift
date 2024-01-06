//
//  MainTabView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import ComposableArchitecture
import SwiftUI

struct MainTabView: View {
  let store: StoreOf<MainTabFeature>
  @AppStorage("colorSchemeMode") var colorSchemeMode = ColorSchemeMode.system

  var body: some View {
    TabView {
      Text("Tab 1")
        .tabItem {
          Image(systemName: "house")
          Text("ToDo")
        }
      MapView(store: store.scope(state: \.map, action: \.map))
        .tabItem {
          Image(systemName: "map")
          Text("Map")
        }
      CreateCacheView(store: store.scope(state: \.createCache, action: \.createCache))
        .tabItem {
          Image(systemName: "plus.app")
          Text("Create")
        }
      Text("Tab 4")
        .tabItem {
          Image(systemName: "tortoise")
          Text("ToDo")
        }
      SettingsView(store: store.scope(state: \.settings, action: \.settings))
        .tabItem {
          Image(systemName: "gear")
          Text("Settings")
        }
    }
    .preferredColorScheme(colorSchemeMode.colorScheme)
    
  }
}

#Preview {
  MainTabView(store: .init(initialState: MainTabFeature.State()) {
    MainTabFeature()
  })
}
