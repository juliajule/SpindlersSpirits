//
//  TastingRowView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 15.04.25.
//

import SwiftUI

struct TastingRowView: View {
    
    let tasting: Tasting
    
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()
    
    var body: some View {
    
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: AppConfig.baseURL + "/" + tasting.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                Image("whisky-def")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(8)
                    .opacity(0.5)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(tasting.name)
                    .font(.headline)
                Text(dateFormatter.string(from: tasting.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(12)
        .shadow(color: Color("Shadows").opacity(0.15), radius: 6, x: 0, y: 4)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    TastingRowView(tasting: MockData.mockTastings[0])
}
