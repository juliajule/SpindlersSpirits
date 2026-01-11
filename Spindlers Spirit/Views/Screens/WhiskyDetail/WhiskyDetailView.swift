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
    @EnvironmentObject private var favoritesManager: FavoritesManager
    
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
                            .padding(.horizontal)
                    case .failure:
                        Image("Whiskyq")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                            .opacity(0.5)
                            .padding(.horizontal)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(whisky.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            favoritesManager.toggleFavorite(whisky)
                        }) {
                            Image(systemName: favoritesManager.isFavorite(whisky) ? "heart.fill" : "heart")
                                .foregroundColor(Color("AccentColor"))
                                .scaleEffect(1.2)
                                .padding(6)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        KeyFactView(title: "Alter", value: "\(whisky.age) Jahre")
                        KeyFactView(title: "Alkohol", value: String(format: "%.1f%%", whisky.alcoholPercentage))
                        KeyFactView(title: "Preis", value: String(format: "%.2f €", whisky.price))
                    }
                    .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        DetailRow(title: "Destillerie", value: whisky.distillery)
                        DetailRow(title: "Füllmenge", value: String(format: "%.2f Liter", whisky.liter))
                        DetailRow(title: "UVP", value: String(format: "%.2f €", whisky.uvp))
                        
                        if let url = URL(string: whisky.link) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Zur Webseite")
                                    .font(.headline)
                                Link(linkLabel(from: whisky.link), destination: url)
                                    .foregroundColor(Color("AccentColor"))
                            }
                            .padding(.top)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Beschreibung")
                            .font(.headline)
                            .padding(.top)
                        Text(whisky.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }                    
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .transition(.opacity)
    }
    
    struct KeyFactView: View {
        var title: String
        var value: String
        
        var body: some View {
            VStack {
                Text(value)
                    .font(.headline)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
    
    struct DetailRow: View {
        var title: String
        var value: String
        
        var body: some View {
            HStack {
                Text(title)
                    .fontWeight(.semibold)
                Spacer()
                Text(value)
                    .foregroundColor(.secondary)
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
        .environmentObject(FavoritesManager())
}

