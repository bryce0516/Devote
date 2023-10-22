//
//  ContentView.swift
//  Devote
//
//  Created by Hye Sung Park on 10/16/23.
//

import SwiftUI

struct ContentView: View {
  
  @State var task: String = ""
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
      VStack {
        VStack(spacing: 16) {
          TextField("New Task", text: $task)
            .padding()
            .background(
              Color(UIColor.systemGray6)
            )
            .cornerRadius(10)
          
          Button(
            action: {
              additem()
            },
            label: {
              Spacer()
            Text("SAVE")
              Spacer()
          })
          .padding()
          .font(.headline)
          .foregroundColor(.white)
          .background(Color.pink)
          .cornerRadius(10)
        } //: VSTACK
        .padding()
        List {
          ForEach(items) { item in
            Text("Items at \(item.timestamp!, formatter: itemFormatter)")
          }
          //        .onDelete(perform: deleteItems)
        } //: LIST
      } //: VSTACK
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
  } //: BODY
}

#Preview {
  ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
