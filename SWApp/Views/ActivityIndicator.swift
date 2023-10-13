//
//  ActivityIndicator.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct ActivityIndicator: View {
    let title: String
    let hintMessage: String

    var body: some View {
        VStack {
            Text(title)
                .foregroundStyle(.primary)
                .font(.title2)
                .padding(.bottom, 15)

            ProgressView()
                .scaleEffect(2)

            Text(hintMessage)
                .foregroundStyle(.secondary)
                .font(.subheadline)
                .padding(.top, 20)
        }
    }
}

#Preview {
    ActivityIndicator(title: "Title",
                      hintMessage: "hintMessage")
}
