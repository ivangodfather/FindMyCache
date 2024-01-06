//
//  PagerView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import ComposableArchitecture
import SwiftUI

struct PagerView: View {
  @Bindable var store: StoreOf<PagerFeature>
  
  var body: some View {
    VStack {
      TabView(selection: $store.selectedPage.sending(\.setSelectedPage)) {
        ForEach(store.pages, content: PagerItemView.init)
      }
      .tabViewStyle(.page)
      .indexViewStyle(.page(backgroundDisplayMode: .always))
      if store.selectedPage == store.pages.last {
        Button {
          store.send(.closePagerTapped)
        } label: {
          Text("Close")
        }
      }
    }
  }
}

#Preview {
  PagerView(
    store: .init(initialState: PagerFeature.State(pages: .onboarding)) {
      PagerFeature()
    }
  )
}
