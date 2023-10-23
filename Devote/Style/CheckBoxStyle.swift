//
//  CheckBoxStyle.swift
//  Devote
//
//  Created by Hye Sung Park on 10/23/23.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    return HStack {
      Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
    } //: HSTACK
  }
}

#Preview {
  Toggle("Placeholder label", isOn: .constant(true))
    .toggleStyle(CheckBoxStyle())
    .padding()
    .previewLayout(.sizeThatFits)
}
