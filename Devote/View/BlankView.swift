//
//  BlankView.swift
//  Devote
//
//  Created by Hye Sung Park on 10/22/23.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
      VStack {
        Spacer()
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
      .background(
        Color.black
      )
      .opacity(0.5)
      .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BlankView()
}