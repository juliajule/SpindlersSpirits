//
//  WhiskyRowView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import SwiftUI

struct WhiskyRowView: View {
    
    let whisky: Whisky

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: AppConfig.baseURL + "/" + whisky.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .clipped()
            } placeholder: {
                Image("images")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .clipped()
            }
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 6) {
                Text(whisky.name)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Alter")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(whisky.age)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 2){
                        Text("Alkohol")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(format: "%.1f%%", whisky.alcoholPercentage))
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
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
    WhiskyRowView(whisky: MockWhiskyData.mockWhiskys[0])
}
