//
//  Constant.swift
//  Devote
//
//  Created by Hye Sung Park on 10/22/23.
//

import Foundation
import SwiftUI

// MARK: - FORMATTER
let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

// MARK: - UI

var backgroundGradient: LinearGradient {
  return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - UX

