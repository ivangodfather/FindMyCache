//
//  PagerView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 4/1/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct PagerFeature {
  @ObservableState
  struct State {
    var pages: [PagerItem]
    var selectedPage: PagerItem
    
    init(pages: [PagerItem]) {
      assert(!pages.isEmpty, "can't initialise without pages")
      self.pages = pages
      self.selectedPage = pages.first!
    }
  }
  enum Action {
    case closePagerTapped
    case setSelectedPage(PagerItem)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .closePagerTapped:
        return .none
      case .setSelectedPage(let page):
        state.selectedPage = page
        return .none
      }
    }
  }
}
