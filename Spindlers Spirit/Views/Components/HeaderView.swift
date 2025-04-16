//
//  HeaderView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 15.04.25.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.system(size: 28, weight: .bold))
            Spacer()
            Button(action: action) {
                Image(systemName: iconName)
                    .imageScale(.large)
                    .padding(.trailing)
            }
        }
        .padding(.vertical, 16)
        .background(Color(.systemBackground).shadow(color: Color("Shadows").opacity(0.15), radius: 2, y: 2))
    }
}

#Preview {
    HeaderView(title: "Verkostung", iconName: "list.bullet") {
        withAnimation {
            print(">>> Action triggered <<<")
        }
    }
}
