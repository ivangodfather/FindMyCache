//
//  MapView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import ComposableArchitecture
import MapKit
import SwiftUI

struct MapView: View {
  @Bindable var store: StoreOf<MapFeature>
  
  var body: some View {
    Map {
      ForEach(store.caches) { cache in
        Annotation(cache.name, coordinate: cache.coordinate) {
          Image(systemName: cache.systemImage)
            .resizable()
            .imageScale(.large)
            .onTapGesture {
              store.send(.selectCache(cache))
            }
        }
      }
    }
    .sheet(item: $store.selectedCache.sending(\.selectCache)) { cache in
      VStack {
        Text(cache.name)
          .font(.title)
                Image(systemName: cache.systemImage)
                  .imageScale(.large)
      }
      .presentationDetents([ .medium, .large])
      .presentationBackgroundInteraction(.enabled)
      .presentationBackground(.thinMaterial)
    }
  }
}

#Preview {
  MapView(store: .init(initialState: MapFeature.State()) {
    MapFeature()
  })
}
