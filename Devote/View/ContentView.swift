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
  
    var body: some View {
      
      Text("helo")
//      List {
//        ForEach(items) { item in
//          Text("Items at \(item.timestamp!, formatter: itemFormatter)")
//        }
//        .onDelete(perform: deleteItems)
//      }
//      .toolbar {
//        
//        #if os(iOS)
//        EditButton()
//        #endif
//        
//        Button(action: additem, label: {
//          Label("Add Item", systemImage: "plus")
//        })
//        
//      }
    }
}

#Preview {
    ContentView()
}
