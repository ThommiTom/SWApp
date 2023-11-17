//
//  ErrorView.swift
//  SWApp
//
//  Created by Thomas Schatton on 17.11.23.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    var retryMeasure: () -> Void

    var body: some View {
        VStack {
            Text("!!! ERROR !!!")
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text(error.localizedDescription)
                .font(.callout)
                .fontWeight(.light)

            Button("Retry Download", action: retryMeasure)
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView(error: NetworkError.invalidData) { print("Retry Measure!") }
}
