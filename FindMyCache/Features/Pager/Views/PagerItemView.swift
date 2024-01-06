//
//  PagerItemView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 5/1/24.
//

import SwiftUI

struct PagerItemView: View {
  let item: PagerItem
  
  var body: some View {
    VStack {
      Text(item.title)
        .font(.title)
      Image(systemName: item.image)
        .resizable()
        .frame(width: 150, height: 150)
      Text(item.description)
        .font(.title)
    }
    .padding(.horizontal)
    .tag(item)
  }
}

#Preview {
  PagerItemView(item: [PagerItem].onboarding.first!)
}
