//
//  DevoteApp.swift
//  Devote
//
//  Created by Hye Sung Park on 10/16/23.
//

import SwiftUI

@main
struct DevoteApp: App {
  
  let persistenceController = PersistenceController()
  
  @AppStorage("isDarkMode") var isDarkMode: Bool = false
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
  }
}
