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
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = task
      newItem.completion = false
      newItem.id = UUID()
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
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
            VStack(alignment: .leading) {
              Text(item.task ?? "")
                .font(.headline)
                .fontWeight(.bold)
              
              Text("Items at \(item.timestamp!, formatter: itemFormatter)")
                .font(.footnote)
                .foregroundColor(.gray)
            } //: LIST ITEM
          }
          .onDelete(perform: deleteItems)
        } //: LIST
      } //: VSTACK
      .navigationTitle("Daily Tasks")
      .navigationBarTitleDisplayMode(.large)
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
