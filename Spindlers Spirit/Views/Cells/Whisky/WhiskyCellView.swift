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
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: AppConfig.baseURL + "/" + whisky.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                Image("whisky-def")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(8)
                    .opacity(0.5)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(whisky.name)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Alter")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(whisky.age)")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Alkohol")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(format: "%.1f%%", whisky.alcoholPercentage))
                            .font(.subheadline)
                    }
                }
            }
            .padding([.horizontal, .bottom], 8)
        }
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color("Shadows").opacity(0.15), radius: 6, x: 0, y: 4)
        .frame(height: 220)
    }
}

#Preview {
    WhiskyCellView(whisky: MockWhiskyData.mockWhiskys[0])
}
