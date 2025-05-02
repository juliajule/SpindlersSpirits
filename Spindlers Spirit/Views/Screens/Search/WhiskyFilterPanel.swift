//
//  WhiskyFilterPanel.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 30.04.25.
//

import SwiftUI
import Sliders

struct WhiskyFilterPanel: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    @State private var ageRange: ClosedRange<Double> = 0...30
    @State private var alcoholRange: ClosedRange<Double> = 40...50
    @State private var priceRange: ClosedRange<Double> = 10...150
    @State private var tastingDateFrom: Date = Date()
    @State private var tastingDateTo: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Group {
                HStack {
                        Text("Alter:")
                        Text("\(Int(ageRange.lowerBound)) – \(Int(ageRange.upperBound)) Jahre")
                            
                }
                .font(.subheadline)
                RangeSlider(range: $ageRange, in: 0...50, step: 1)
                        .frame(height: 24)
            }
            
            Group {
                HStack {
                    Text("Alkoholgehalt:")
                    Text(String(format: "%.1f – %.1f %%", alcoholRange.lowerBound, alcoholRange.upperBound))
                        
                }
                .font(.subheadline)
                RangeSlider(range: $alcoholRange, in: 30...70, step: 0.1)
                    .frame(height: 24)

            }
            
            Group {
                HStack {
                    Text("Preis:")
                    Text(String(format: "%.0f – %.0f €", priceRange.lowerBound, priceRange.upperBound))
                }
                .font(.subheadline)
                RangeSlider(range: $priceRange, in: 0...300, step: 5)
                    .frame(height: 24)
            }
            
            Group {
                Text("Verkostungsdatum")
                    .font(.subheadline)
                
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading) {
                        Text("Von")
                            .font(.caption)
                        
                        DatePicker("", selection: $tastingDateFrom, displayedComponents: .date)
                            .labelsHidden()
                            .frame(width: 120, height: 28)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .clipped()
                            .onChange(of: tastingDateFrom) { oldValue, newValue in
                                viewModel.tastingDateFrom = newValue
                                viewModel.searchAsyncSafe()
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Bis")
                            .font(.caption)
                        
                        DatePicker("", selection: $tastingDateTo, displayedComponents: .date)
                            .labelsHidden()
                            .frame(width: 120, height: 28)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .clipped()
                            .onChange(of: tastingDateTo) { oldValue, newValue in
                                viewModel.tastingDateTo = newValue
                                viewModel.searchAsyncSafe()
                            }
                    }
                    Spacer()
                }
            }
            
            Button("Filter zurücksetzen") {
                clearFilters()
            }
            .foregroundColor(.red)
            .padding(.top, 8)
        }
        .rangeSliderStyle(
                HorizontalRangeSliderStyle(
                    track:
                        HorizontalRangeTrack(
                            view: Capsule().foregroundColor(Color("Shadows"))
                        )
                        .background(Capsule().foregroundColor(Color("Shadows").opacity(0.25)))
                        .frame(height: 4),
                    lowerThumb: Circle().foregroundColor(Color("Shadows")),
                    upperThumb: Circle().foregroundColor(Color("Shadows")),
                    lowerThumbSize: CGSize(width: 20, height: 20),
                    upperThumbSize: CGSize(width: 20, height: 20)
                )
            )
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .onChange(of: ageRange) {
            viewModel.minAge = Int(ageRange.lowerBound)
            viewModel.maxAge = Int(ageRange.upperBound)
            Task {
                await viewModel.search()
            }
        }
        .onChange(of: alcoholRange) {
            viewModel.minAlcoholPercentage = alcoholRange.lowerBound
            viewModel.maxAlcoholPercentage = alcoholRange.upperBound
            Task {
                await viewModel.search()
            }
        }
        .onChange(of: priceRange) {
            viewModel.minPrice = priceRange.lowerBound
            viewModel.maxPrice = priceRange.upperBound
            Task {
                await viewModel.search()
            }
        }
    }

    private func clearFilters() {
        ageRange = 0...30
        alcoholRange = 40...50
        priceRange = 10...150
        viewModel.minAge = nil
        viewModel.maxAge = nil
        viewModel.minAlcoholPercentage = nil
        viewModel.maxAlcoholPercentage = nil
        viewModel.minPrice = nil
        viewModel.maxPrice = nil
        viewModel.tastingDateFrom = nil
        viewModel.tastingDateTo = nil
    }
}
    
extension Binding where Value == Date {
    init(_ source: Binding<Date?>, replacingNilWith defaultValue: Date) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { source.wrappedValue = $0 }
        )
    }
}

#Preview {
    WhiskyFilterPanel(viewModel: SearchViewModel())
}
