//
//  UserSectionView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import SwiftUI

struct UserSectionView: View {
  var body: some View {
    Section {
      NavigationLink {
        Form {
          Button("Delete my account", role: .destructive) {
            
          }
        }
      } label: {
        HStack(spacing: 16) {
          AsyncImage(url: URL(string: "https://www.noggin.com/app/uploads/2019/06/Rubble-Copy2.jpg")) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
            
          } placeholder: {
            Color.gray
          }
          .frame(width: 56, height: 56)
          .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
          VStack(alignment: .leading) {
            Text("Ivan Ruiz")
              .lineLimit(1)
              .font(.headline)
            Text("Update your image, email or username.")
              .lineLimit(2)
              .font(.callout)
          }
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    Form {
      UserSectionView()
    }
  }
}
