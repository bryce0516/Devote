//
//  ContentView.swift
//  Devote
//
//  Created by Hye Sung Park on 10/16/23.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: - PROPERTIES
  @AppStorage("isDarkMode") private var isDarkMode: Bool = false
  
  @State var task: String = ""
  @State private var showNewTaskItem: Bool = false
  @State private var isActive: CGFloat = -50
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .default
  )
  private var items: FetchedResults<Item>
  

  
  
  
  
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
      ZStack {
        
        // MARK: - MAIN VIEW
        VStack {
          // MARK: - HEADER
          
          HStack(spacing: 10) {
            // TITLE
            Text("Devote")
              .font(.system(.largeTitle, design: .rounded))
              .fontWeight(.heavy)
              .padding(.leading, 4)
            
            Spacer()
            
            // EDIT BUTTON
            EditButton()
              .font(.system(size: 16, weight: .semibold, design: .rounded))
              .padding(.horizontal, 10)
              .frame(minWidth: 70, minHeight: 24)
              .background(
                Capsule().stroke(Color.white, lineWidth: 2)
              )
            // APPEARENCE BUTTON
            Button(action: {
              // TOGGLE APPEARENCE
              isDarkMode.toggle()
              playSound(sound: "sound-tap", type: "mp3")
              feedback.notificationOccurred(.success)
            }, label: {
              Image(systemName: isDarkMode ? "moon.circle.fill": "moon.circle")
                .resizable()
                .frame(width: 24, height: 24)
                .font(.system(.title, design: .rounded))
            })
            
          } //: HSTACK
          .padding()
          .foregroundColor(.white)
          
          Spacer(minLength: 80)
          // MARK: - NEW TASK BUTTON
          
          Button(action: {
            showNewTaskItem = true
            playSound(sound: "sound-ding", type: "mp3")
            feedback.notificationOccurred(.success)
          }, label: {
            Image(systemName: "plus.circle")
              .font(.system(size: 30, weight: .semibold, design: .rounded))
            Text("New Task")
              .font(.system(size: 24, weight: .bold, design: .rounded))
            
          })
          .foregroundColor(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 15)
          .background(
            LinearGradient(
              gradient: Gradient(
                colors: [Color.pink, Color.blue]),
              startPoint: .leading,
              endPoint: .trailing
            )
          )
          .shadow(
            color: Color(red: 0,green:0, blue:0, opacity: 0.25),
            radius: 8,
            x: 0.0,
            y: 4.0
          )
          .cornerRadius(30)
          
          // MARK: - TASKS
          List {
            ForEach(items) { item in
              ListRowItemView(item: item)
              //              VStack(alignment: .leading) {
              //                Text(item.task ?? "")
              //                  .font(.headline)
              //                  .fontWeight(.bold)
              //
              //                Text("Items at \(item.timestamp!, formatter: itemFormatter)")
              //                  .font(.footnote)
              //                  .foregroundColor(.gray)
              //              } //: LIST ITEM
            }
            .onDelete(perform: deleteItems)
          } //: LIST
          .listStyle(InsetGroupedListStyle())
          .shadow(
            color: Color(
              red:0, green: 0, blue:0, opacity: 0.3
            ),
            radius: 12
          )
          .padding(.vertical, 0)
          .frame(maxWidth: 640)
        } //: VSTACK
        .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
        .transition(.move(edge: .bottom))
        .offset(x:0, y:isActive)
        .onAppear {
          withAnimation(.easeOut(duration: 0.5)) {
            isActive = 0
          }
        }
        // MARK: - NEW TASK ITEM
        
        if showNewTaskItem {
          BlankView(
            backgroundColor: isDarkMode ? Color.black : Color.gray,
            backgroundOpacity: isDarkMode ? 0.3 : 0.5
          )
          .onTapGesture {
            withAnimation() {
              showNewTaskItem = false
            }
          }
          NewTaskItemView(isShowing: $showNewTaskItem)
        }
        
        
      } //: ZSTACK
      .onAppear() {
        UITableView.appearance().backgroundColor = UIColor.clear
      }
      .navigationTitle("Daily Tasks")
      .navigationBarTitleDisplayMode(.large)
      .background(
        BackgroundImageView()
          .blur(radius: showNewTaskItem ? 8.0: 0, opaque: false)
      )
      .navigationBarHidden(true)
      .toolbar {
#if os(iOS)
        ToolbarItem(placement: .topBarTrailing) {
          EditButton()
        }
#endif
        //        ToolbarItem(placement: .topBarTrailing) {
        //          Button(action: additem, label: {
        //            Label("Add Item", systemImage: "plus")
        //          })
        //        }
      } //: TOOLBAR
      .background(
        BackgroundImageView()
      )
      .background(
        backgroundGradient.ignoresSafeArea(.all)
      )
    } //: NAVIGATION
    .navigationViewStyle(StackNavigationViewStyle())
  } //: BODY
}

#Preview {
  ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
