//
//  PopoverView.swift
//  wilsonsmenuapp
//
//  Created by Wilson Chen on 11/3/22.
//

import SwiftUI


struct PopoverView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [])
    var allData: FetchedResults<QLLink>
    
    @State private var newTask: String = ""
    @State private var editingTask: Bool = false
    @State private var taskID: QLLink?
    
    private func deleteItems(dd: QLLink) {
        
        if !dd.done {
            return
        }
        
        viewContext.delete(dd)
        try? viewContext.save()
        
    }
    
    private func name() -> String {
        let firstname = NSFullUserName().split(separator: " ")[0]
        let hour = Calendar.current.component(.hour, from: Date())
        var timeOfDay = ""
        switch hour {
        case 6..<12 : timeOfDay = "Good Morning, "
        case 12..<18 : timeOfDay = "Good Afternoon, "
        case 18..<24 : timeOfDay = "Good Evening, "
        default: timeOfDay = "Good Evening, "
        }
        
        return String(timeOfDay + firstname)
    }
    
    private func toggleIfDone(dd: QLLink) {
        dd.done = !dd.done
        try? viewContext.save()
    }
    
    private func deleteAll() {

        for value in allData {
                        
            deleteItems(dd: value)
        }
    }
    
    private func edit(dd: QLLink) {
        newTask = dd.data!
        taskID = dd
        editingTask = true
    }
    
    var body: some View {
        

        VStack(alignment: .leading) {
            
            HStack {
            
                Text(name())
                    .font(.system(size: 13, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    
            
                HStack {
                    Button(action: { deleteAll() }, label: {
                        Image(systemName: "trash.circle")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundColor(.secondary)
                        })
                        .buttonStyle(PlainButtonStyle())
                        .accessibilityLabel(Text("Delete All"))
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 7.5)
            }
            
            ForEach(allData, id: \.wrappedID) { task in
                let _ = print("hi!")
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                        .frame(height: 45)
                        
                
                    HStack {
                        
                        if task.wrappedDone {
                            
                            Button(
                                action: {
                                    toggleIfDone(dd: task)
                                },
                                
                                label: {
                                    Image("custom.checkmark.square.fill")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                        //.foregroundColor(.secondary)
                                }
                            )
                            .buttonStyle(PlainButtonStyle())
                            .padding(.leading, 10)
                            
                            Button(action: {edit(dd: task)}, label: {
                                Text(task.wrappedData)
                                    .font(.system(size: 12, weight: .medium))
                                    .strikethrough()
                                Spacer()
                            })
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityLabel(Text("Text"))
                            
                        } else {
                            Button(
                                action: {
                                    
                                    toggleIfDone(dd: task)
                                },
                                
                                label: {
                                    Image("square")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                        //.foregroundColor(.secondary)
                                }
                            )
                            .buttonStyle(PlainButtonStyle())
                            .padding(.leading, 10)
                            
                            Button(action: {edit(dd: task)}, label: {
                                Text(task.wrappedData)
                                    .font(.system(size: 12, weight: .medium))
                                Spacer()
                            })
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityLabel(Text("Text"))
                        }
                        
                        
                        
                        
                        
                        
                        Button(action: {deleteItems(dd: task)}, label: {
                                Image("multiply.circle.fill")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                                
                            })
                            .buttonStyle(PlainButtonStyle())
                            .accessibilityLabel(Text("Close"))
                            .padding(.trailing, 10)
                        
                    }
                }
                .padding(.bottom, 5)
            }
            
            Divider()
                .padding(.top, 5)
                .padding(.bottom, 10)
            
            VStack {
                
                
                TextField("", text: $newTask, onCommit: {
                    
                    if editingTask {
                        
                        taskID!.data = newTask
                        
                        if newTask == "" {
                            deleteItems(dd: taskID!)
                        }
                        editingTask = false
                        
                    } else {
                    
                        if !newTask.isEmpty {
                            let qllink = QLLink(context: viewContext)
                            qllink.id = UUID()
                            qllink.data = newTask
                            qllink.done = false
                            
                        }
                    }
                    
                    try? viewContext.save()
                    newTask = ""
                })
                    .padding(.leading, 8)
                    .background(border)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.bottom, 8)
                    .font(.system(size: 12, weight: .medium))
                    
                    
                    
                
            }
        }
        .padding()
        .frame(width: 350)
        
    }
    var border: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
            .frame(height: 30)
            
      }
    
    
}


struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView()
    }
}



extension NSTextField {
        open override var focusRingType: NSFocusRingType {
                get { .none }
                set { }
        }
}
