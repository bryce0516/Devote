//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Hye Sung Park on 10/22/23.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
      Image("rocket")
        .antialiased(true)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea(.all)
    }
}

#Preview {
    BackgroundImageView()
}
