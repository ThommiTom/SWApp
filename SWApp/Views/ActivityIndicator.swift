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
            Spacer()
            Text(title)
                .foregroundStyle(.primary)
                .font(.title2)
            Spacer()
            ProgressView()
                .scaleEffect(2)
            Spacer()
            Text(hintMessage)
                .foregroundStyle(.secondary)
                .font(.subheadline)
            Spacer()
        }
    }
}

#Preview {
    ActivityIndicator(title: "Title",
                      hintMessage: "hintMessage")
}
