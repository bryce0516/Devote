//
//  ContentView.swift
//  Devote
//
//  Created by Hye Sung Park on 10/16/23.
//

import SwiftUI

struct ContentView: View {
  
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .default
  )
  private var items: FetchedResults<Item>
  
  
  private func additem() {
    
  }
  
  private func deleteItems() {
    
  }
  var body: some View {
    
    NavigationView {
      List {
        ForEach(items) { item in
          Text("Items at \(item.timestamp!)")
//          Text("Items at \(item.timestamp!, formatter: itemFormatter)")
        }
//        .onDelete(perform: deleteItems)
      } //: LIST
      .toolbar {
        
        #if os(iOS)
        ToolbarItem(placement: .topBarLeading) {
          EditButton()
        }
        #endif
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: additem, label: {
            Label("Add Item", systemImage: "plus")
          })
        }
        
      } //: TOOLBAR
    } //: NAVIGATION
  }
}

#Preview {
  ContentView()
}
