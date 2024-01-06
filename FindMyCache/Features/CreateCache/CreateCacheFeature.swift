//
//  CreateCacheFeature.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 7/1/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CreateCacheFeature {
  @ObservableState
  struct State {
    var name: String = ""
    var difficulty = Cache.Difficulty.easy
    var latitude = ""
    var longitue = ""
  }
  
  enum Action: BindableAction {
    case binding(BindingAction<State>)
  }
  
  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce<State, Action> { state, action in
      switch action {
      case .binding:
        return .none
      }
    }
  }
  
  
  
}
