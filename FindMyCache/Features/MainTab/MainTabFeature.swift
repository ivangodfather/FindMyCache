//
//  MainTabFeature.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import ComposableArchitecture

@Reducer
struct MainTabFeature {
  @ObservableState
  struct State {
    var createCache = CreateCacheFeature.State()
    var map = MapFeature.State()
    var settings = SettingsFeature.State()
  }
  
  enum Action {
    case createCache(CreateCacheFeature.Action)
    case map(MapFeature.Action)
    case settings(SettingsFeature.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: \.map, action: \.map) {
      MapFeature()
    }
    Scope(state: \.settings, action: \.settings) {
      SettingsFeature()
    }
    Scope(state: \.createCache, action: \.createCache) {
      CreateCacheFeature()
    }
    EmptyReducer()
  }
}
