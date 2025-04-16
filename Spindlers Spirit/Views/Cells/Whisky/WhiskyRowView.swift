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
        
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: AppConfig.baseURL + "/" + whisky.imageUrl)) {image in
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
            
            VStack(alignment: .leading, spacing: 4) {
                Text(whisky.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("Alter: \(whisky.age) Jahre")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(String(format: "Alkohol: %.1f%%", whisky.alcoholPercentage))
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
    WhiskyRowView(whisky: MockWhiskyData.mockWhiskys[0])
}
