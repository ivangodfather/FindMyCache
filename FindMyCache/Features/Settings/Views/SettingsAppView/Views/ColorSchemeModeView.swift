//
//  ColorSchemeModeView.swift
//  FindMyCache
//
//  Created by Ivan Ruiz on 8/1/24.
//

import SwiftUI

enum ColorSchemeMode: String {
    case system, dark, light
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .dark: return .dark
        case .light: return .light
        }
    }
}

struct ColorSchemeModeView: View {
    
    @AppStorage("colorSchemeMode") var colorSchemeMode = ColorSchemeMode.system
    
    var body: some View {
      LabeledContent {
        Menu {
              Button("System", action: {
                colorSchemeMode = .system
              })
              Button("Dark", action: {
                colorSchemeMode = .dark
              })
              Button("Light", action: {
                colorSchemeMode = .light
              })
        } label: {
          Text("\(colorSchemeMode.rawValue.capitalized) \(Image(systemName: "chevron.up.chevron.down"))")
            .foregroundStyle(.secondary)
        }

      } label: {
          Label("Color Scheme", systemImage: "sun.max.circle")
      }
      .preferredColorScheme(colorSchemeMode.colorScheme)
    }
}


#Preview {
    ColorSchemeModeView()
}
