import SwiftUI

struct StatCard: View {
    let title: String
    let valueText: String
    let unit: String

    var body: some View {
        VStack(spacing: 6) {
            Text(title).font(.caption).foregroundColor(.secondary)
            Text(valueText).font(.title3).bold()
            Text(unit).font(.caption2).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    
        .background(Color(.secondarySystemBackground))        
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
