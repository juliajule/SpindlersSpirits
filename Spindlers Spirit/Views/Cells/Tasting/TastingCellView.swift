//
//  TastingCellView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 15.04.25.
//

import SwiftUI

struct TastingCellView: View {

    let tasting: Tasting
    
    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                AsyncImage(url: URL(string: AppConfig.baseURL + "/" + tasting.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image("whisky-def")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.5)
                }
            }
            .frame(height: 120)
            .clipped()
            .cornerRadius(10)
            
            Text(tasting.name)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(dateFormatter.string(from: tasting.date))
                .font(.subheadline)
                .foregroundColor(.gray)

            //Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 220)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color("Shadows").opacity(0.15), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    TastingCellView(tasting: MockData.mockTastings[0])
}
