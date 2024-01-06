//
//  CreateCacheView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 7/1/24.
//

import ComposableArchitecture
import SwiftUI

extension Cache {
  enum Difficulty: String {
    case easy
    case medium
    case hard
  }
}

struct CreateCacheView: View {
  @Bindable var store: StoreOf<CreateCacheFeature>
  
    var body: some View {
      NavigationStack {
        Form {
          Section(header: Text("Cache name")) {
            TextField("Enter a name, ex: The Hiddem gem", text: $store.name)
          }
          Section(header: HStack {
            Text("Coordinates")
            Button {
              
            } label: {
              Text("Fill using location")
                .font(.caption)
            }
          }) {
            HStack {
              TextField("Latitude", text: $store.latitude)
              TextField("Longitude", text: $store.longitue)
            }
            .textFieldStyle(.roundedBorder)
          }
          Section(header: Text("Select a difficulty:"), footer: Text("Easy: Beginner-friendly. Medium: Some experience needed. Hard: Challenging for experts.")) {
            Picker("Difficulty", selection: $store.difficulty) {
              Text("Easy")
                .tag(Cache.Difficulty.easy)
              
              Text("Medium")
                .tag(Cache.Difficulty.medium)
              Text("Hard")
                .tag(Cache.Difficulty.hard)
            }
            .pickerStyle(.segmented)
            

          }
          Button {
            
          } label: {
            Text("Create new cache")
              .bold()
              .frame(maxWidth: .infinity)
          }
          .listRowBackground(Color.accentColor)
          .foregroundStyle(.white)
          
        }
        .navigationTitle("Create cache")
      }
    }
}

#Preview {
  CreateCacheView(store: .init(initialState: CreateCacheFeature.State()){
    CreateCacheFeature()
  })
}
