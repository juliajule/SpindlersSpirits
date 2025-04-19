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
            AsyncImage(url: URL(string: AppConfig.baseURL + "/" + whisky.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image("whisky-def")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
            }
            .frame(width: 100, height: 100)
            .clipped()
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 6) {
                Text(whisky.name)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .padding(.bottom)
            
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Alter")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(whisky.age)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    VStack(alignment: .leading, spacing: 2){
                        Text("Alkohol")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(format: "%.1f%%", whisky.alcoholPercentage))
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color("Shadows").opacity(0.15), radius: 6, x: 0, y: 4)
    }
        
//        HStack(spacing: 12) {
//            AsyncImage(url: URL(string: AppConfig.baseURL + "/" + whisky.imageUrl)) {image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 80, height: 80)
//                    .clipped()
//                    .cornerRadius(8)
//            } placeholder: {
//                Image("whisky-def")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 80, height: 80)
//                    .clipped()
//                    .cornerRadius(8)
//                    .opacity(0.5)
//            }
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(whisky.name)
//                    .font(.headline)
//                    .lineLimit(1)
//                
//                Text("Alter: \(whisky.age) Jahre")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                Text(String(format: "Alkohol: %.1f%%", whisky.alcoholPercentage))
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
//            
//            Spacer()
//        }
//        .padding()
//        .background(Color(uiColor: .systemBackground))
//        .cornerRadius(12)
//        .shadow(color: Color("Shadows").opacity(0.15), radius: 6, x: 0, y: 4)
//        .padding(.horizontal)
//        .padding(.vertical, 4)
//    }
}

#Preview {
    WhiskyRowView(whisky: MockWhiskyData.mockWhiskys[0])
}
