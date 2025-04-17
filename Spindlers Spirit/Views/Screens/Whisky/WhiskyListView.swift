//
//  WhiskyListView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import SwiftUI

struct WhiskyListView: View {
    
    let tasting: Tasting
    @ObservedObject var viewModel: WhiskyViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                HeaderView(title: "Whiskys", iconName: "list.bullet") {
                    withAnimation {
                        viewModeSettings.viewMode = .list
                    }
                }
                .overlay(
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
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .frame(maxWidth: .infinity)
                                            .clipped()
                                            .cornerRadius(12)
                                    case .failure:
                                        Image("whisky-def")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .frame(maxWidth: .infinity)
                                            .clipped()
                                            .cornerRadius(12)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .padding(.horizontal)

                                VStack(spacing: 4) {
                                    if !tasting.description.isEmpty {
                                        Text(tasting.description)
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.center)
                                            .padding(.top, 4)
                                    }
                                }
                                .padding(.horizontal)

                                if viewModel.isLoading {
                                    ProgressView("Lade Whiskys…")
                                        .frame(maxWidth: .infinity, minHeight: 200)
                                } else if let error = viewModel.errorMessage {
                                    Text(error)
                                        .foregroundColor(.red)
                                        .padding()
                                } else if viewModel.whiskys.isEmpty {
                                    EmptyStateView(imageName: "whisky-def", message: "Keine Whiskys gefunden.")
                                } else {
                                    VStack(spacing: 12) {
                                        ForEach(viewModel.whiskys) { whisky in
                                            WhiskyRowView(whisky: whisky)
                                                .onTapGesture {
                                                    // Detailnavigation (geplant)
                                                }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 12)
                        }
                        .transition(.opacity)
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    let viewModel = WhiskyViewModel()
    WhiskyListView(tasting: MockData.mockTastings[0], viewModel: viewModel)
}
