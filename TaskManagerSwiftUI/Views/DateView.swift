
import SwiftUI

struct DateView: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var correntDate: Date = Date()
    @State var quickNote: String = ""
    @State var editing: Bool = false
    @State var edit: Bool
    @State var save: Bool = false
    @AppStorage("note") var note: String?
    
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading) {
                Text(correntDate.formatted(.dateTime.hour(.defaultDigits(amPM: .omitted)).minute()))
                Text(correntDate.formatted(.dateTime.weekday()))
            }
            .font(.system(size: 50, weight: .medium, design: .default))
            Rectangle()
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.black.opacity(0.4))
                .overlay(alignment: .top, content: {
                    Rectangle()
                        .frame(height: 20)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.yellow)
                })
                .cornerRadius(10)
                .overlay(alignment: .center, content: {
                    if editing {
                        TextField("new note", text: $quickNote)
                            .foregroundColor(Color.red)
                            .frame(height: 30)
                            .background(Color.gray.opacity(0.2).cornerRadius(10))
                            .offset(y: 5)
                    } else {
                        Text(note ?? "no data").bold()
                            .minimumScaleFactor(0.6)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                        
                    }
                })
                .overlay(alignment: .bottomTrailing) {
                    if edit {
                        Button(action: {
                            editing.toggle()
                            save.toggle()
                            edit.toggle()
                            
                            if !quickNote.isEmpty {
                                note = quickNote
                                quickNote = ""
                            }
                            
                        }, label: {
                            Image(systemName: "pencil").bold()
                                .font(.title2)
                                .foregroundColor(.black)
                            
                        })
                        .padding(7)
                        
                        
                        
                    }
                    if save {
                        Button(action: {
                            if !quickNote.isEmpty {
                                note = quickNote
                                quickNote = ""
                            }
                            editing.toggle()
                            save.toggle()
                            
                        }, label: {
                            Image(systemName: "checkmark").bold()
                                .foregroundColor(.blue)
                        })
                        .padding(7)
                    }
                }
            
        }
        .onReceive(timer, perform: { value in
            correntDate = value
        })
    }
}


struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(edit: false)
    }
}
