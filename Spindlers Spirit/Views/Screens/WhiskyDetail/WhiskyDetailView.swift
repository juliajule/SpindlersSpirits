//
//  WhiskyDetailView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 24.04.25.
//

import SwiftUI

struct WhiskyDetailView: View {
    
    let whisky: Whisky
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(10)
                                .background(Color(.systemBackground).opacity(0.8))
                                .clipShape(Circle())
                        }
                        .padding(.leading)
                        Spacer()
                    }
                    Text("Whisky")
                        .font(.system(size: 28, weight: .bold))
                }
                .padding(.top, 12)
                .padding(.bottom, 8)
                .background(Color(.systemBackground).shadow(color: Color("Shadows").opacity(0.15), radius: 2, y: 2))
            }
        
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: "\(AppConfig.baseURL)/\(whisky.imageUrl)")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                                .background(Color(.secondarySystemBackground))
                                .padding(.horizontal)
                        case .failure:
                            Image("whisky-def")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                                .background(Color(.secondarySystemBackground))
                                .padding(.horizontal)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    HStack {
                        Text(whisky.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            // Favorit-Logik später
                        }) {
                            Image(systemName: "heart")
                                .foregroundColor(Color("AccentColor"))
                                .scaleEffect(1.2)
                                .padding(6)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        InfoRow(label: "Destillerie:", value: whisky.distillery)
                        InfoRow(label: "Alter:", value: "\(whisky.age) Jahre")
                        InfoRow(label: "Alkoholgehalt:", value: String(format: "%.2f %%", whisky.alcoholPercentage))
                        InfoRow(label: "Füllmenge:", value: String(format: "%.2f Liter", whisky.liter))
                        InfoRow(label: "Preis:", value: String(format: "%.2f €", whisky.price))
                        InfoRow(label: "UVP:", value: String(format: "%.2f €", whisky.uvp))

                        if let url = URL(string: whisky.link) {
                            HStack(alignment: .top) {
                                Text("Zur Webseite:")
                                    .frame(width: 120, alignment: .leading)
                                    .fontWeight(.semibold)
                                Link(linkLabel(from: whisky.link), destination: url)
                                    .foregroundColor(Color("AccentColor"))
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Beschreibung")
                            .font(.headline)
                            .padding(.top)
                        Text(whisky.description)
                    }
                    .font(.body)
                    .padding(.top)
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    struct InfoRow: View {
        var label: String
        var value: String

        var body: some View {
            HStack(alignment: .top) {
                Text(label)
                    .frame(width: 120, alignment: .leading)
                    .fontWeight(.semibold)
                Text(value)
            }
        }
    }
    
    func linkLabel(from urlString: String) -> String {
        if let url = URL(string: urlString),
           let host = url.host {
            return "\(host.replacingOccurrences(of: "www.", with: ""))"
        }
        return "Webseite"
    }
}

#Preview {
    WhiskyDetailView(whisky: MockWhiskyData.mockWhiskys[0])
}
