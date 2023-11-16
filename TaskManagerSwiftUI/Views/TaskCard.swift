
import SwiftUI

struct TaskCard: View {
    
    @Environment(\.self) var envi
    @EnvironmentObject var taksManagerViewModel: TaskManagerViewModel
    var title: String = ""
    var descriptiont: String = ""
    var iconName: String = ""
    var colorName: String = ""
    var dataData: String = ""
    var dataTime: String = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .foregroundColor(Color.gray.opacity(0.7))
                .overlay(alignment: .leading, content: {
                    Rectangle()
                        .frame(width: 6, height: 130)
                        .foregroundColor(Color(colorName))
                        .cornerRadius(5)
                    
                })
                .overlay(alignment: .top,content: {
                    VStack(spacing: 0) {
                        HStack {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Spacer()
                            Image(iconName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 35, height: 35)
                                .clipShape(Rectangle())
                        }
                        .padding(.horizontal, 10)
                        Text(descriptiont)
                            .minimumScaleFactor(0.9)
                            .multilineTextAlignment(.leading)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 85)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                    }
                    .padding(.vertical, 5)
                })
                .overlay(alignment: .bottomLeading, content: {
                    HStack {
                        Image(systemName: "calendar")
                        Text(dataData)
                        Image(systemName: "clock.arrow.circlepath")
                        Text(dataTime)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    
                })
                .cornerRadius(10)
                .padding(.horizontal, 3)
        }
    }
}

struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard()
            .environmentObject(TaskManagerViewModel())
    }
}
