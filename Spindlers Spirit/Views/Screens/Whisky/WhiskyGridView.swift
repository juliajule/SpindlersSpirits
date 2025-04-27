//
//  WhiskyGridView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import SwiftUI

struct WhiskyGridView: View {
    
    let tasting: Tasting
    @ObservedObject var viewModel: WhiskyViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @Environment(\.dismiss) private var dismiss
    var onSelect: (Whisky) -> Void

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {
            HeaderView(title: "Whiskys", iconName: "list.bullet") {
                withAnimation {
                    viewModeSettings.viewMode = .list
                }
            }
            .overlay(
                HStack {
                    Button(action: { dismiss() }) {
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
            )
            .zIndex(1)
            
            VStack(spacing: 4) {
                Text("Tasting: \(tasting.name)")
                    .font(.headline)
                Text(tasting.date.formatted(date: .long, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
            
            Group {
                if viewModel.isLoading {
                    ProgressView("Lade Whiskys...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.whiskys.isEmpty {
                    EmptyStateView(imageName: "whisky-def", message: "Keine Whiskys gefunden.")
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            AsyncImage(url: URL(string: "\(AppConfig.baseURL)/\(tasting.imageUrl)")) { phase in
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
                                    Image("images")
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
                            .padding(.horizontal)
                            
                            VStack(spacing: 4) {
                                Text(tasting.description ?? "Keine Beschreibung verfügbar.")
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 4)
                            }
                            .padding(.horizontal)

                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.whiskys) { whisky in
                                    WhiskyCellView(whisky: whisky)
                                        .onTapGesture {
                                            onSelect(whisky)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 12)
                    }
                    .transition(.opacity)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let viewModel = WhiskyViewModel()
    let onSelect: (Whisky) -> Void = { _ in }
    WhiskyGridView(tasting: MockData.mockTastings[0], viewModel: viewModel, onSelect: onSelect)
}
