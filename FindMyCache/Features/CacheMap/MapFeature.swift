//
//  MapFeature.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import ComposableArchitecture

@Reducer
struct MapFeature {
  @ObservableState
  struct State {
    var caches = [Cache].mock
    var selectedCache: Cache?
  }
  
  enum Action {
    case selectCache(Cache?)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .selectCache(let cache):
        state.selectedCache = cache
        return .none
      }
    }
  }
}
