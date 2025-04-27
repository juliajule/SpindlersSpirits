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
    
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: AppConfig.baseURL + "/" + tasting.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .clipped()
                    .frame(maxWidth: 80, maxHeight: 80)
            } placeholder: {
                Image("tastingQ")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .clipped()
                    .frame(maxWidth: 80, maxHeight: 80)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(tasting.name)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                Text(dateFormatter.string(from: tasting.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color("Shadows").opacity(0.15), radius: 6, x: 0, y: 4)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    TastingRowView(tasting: MockData.mockTastings[0])
}
