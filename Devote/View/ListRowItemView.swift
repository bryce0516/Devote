//
//  ListRowItemView.swift
//  Devote
//
//  Created by Hye Sung Park on 10/23/23.
//

import SwiftUI

struct ListRowItemView: View {
  
  @Environment(\.managedObjectContext) var viewContext
  @ObservedObject var item: Item
  
  
    var body: some View {
      Toggle(isOn: $item.completion) {
        Text(item.task ?? "")
          .font(.system(.title2, design: .rounded))
          .fontWeight(.heavy)
          .foregroundColor(item.completion ? Color.pink : Color.primary)
          .padding(.vertical, 12)
          .animation(.default, value: 1)
      }//: TOGGLE
      .toggleStyle(CheckBoxStyle())
      .onReceive(item.objectWillChange, perform: { _ in
        if self.viewContext.hasChanges {
          try? self.viewContext.save()
        }
      })
      
    }
}
