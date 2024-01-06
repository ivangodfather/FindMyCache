//
//  FrequentQuestionsView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 6/1/24.
//

import SwiftUI

struct FrequentQuestionsView: View {
  var body: some View {
    Form {
      Section(header: Text("Geocaching")) {
        DisclosureGroup("What is a cache?") {
          Text("A cache is a hidden container or item that is part of a global outdoor treasure-hunting game. Participants use GPS or other navigational techniques to hide and seek these caches.")
        }
        DisclosureGroup("How to find a cache") {
          Text("To find a cache, use a GPS device or a GPS-enabled mobile app to navigate to the specific coordinates where the cache is hidden. Look for unusual or out-of-place items in the area.")
        }
        DisclosureGroup("What to hide cache?") {
          Text("Common items to hide in a cache include small toys, keychains, or trinkets. It's important to ensure the items are weatherproof and non-perishable. Always respect the local guidelines and nature.")
        }
        DisclosureGroup("How to mark a cache as found") {
          Text("Once you find a cache, you can mark it as found by logging your discovery in a physical logbook inside the cache or using an online geocaching platform or mobile app.")
        }
      }
      Section(header: Text("Your data")) {
        DisclosureGroup("How to find a cache") {
          Text("To find a cache, use a GPS device or a GPS-enabled mobile app to navigate to the specific coordinates where the cache is hidden. Look for unusual or out-of-place items in the area.")
        }
        DisclosureGroup("What to hide cache?") {
          Text("Common items to hide in a cache include small toys, keychains, or trinkets. It's important to ensure the items are weatherproof and non-perishable. Always respect the local guidelines and nature.")
        }
        DisclosureGroup("How to mark a cache as found") {
          Text("Once you find a cache, you can mark it as found by logging your discovery in a physical logbook inside the cache or using an online geocaching platform or mobile app.")
        }
      }

    }
    .navigationTitle("Frequent Questions")
  }
}


#Preview {
    FrequentQuestionsView()
}
