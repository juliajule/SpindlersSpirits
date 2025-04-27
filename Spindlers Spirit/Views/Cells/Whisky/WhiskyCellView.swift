//
//  WhiskyCellView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import SwiftUI

struct WhiskyCellView: View {
    
    let whisky: Whisky

    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                AsyncImage(url: URL(string: AppConfig.baseURL + "/" + whisky.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .clipped()
                } placeholder: {
                    Image("Whiskyq")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .clipped()
                }
            }
            .frame(height: 120)
            .clipped()
            .cornerRadius(10)
            
            Text(whisky.name)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, alignment: .leading)
                            
            HStack(spacing: 30){
                VStack(alignment: .leading, spacing: 6) {
                    Text("Alter")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(whisky.age)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading, spacing: 6){
                    Text("Alkohol")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(String(format: "%.1f%%", whisky.alcoholPercentage))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 250)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color("Shadows").opacity(0.15), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    WhiskyCellView(whisky: MockWhiskyData.mockWhiskys[0])
}
