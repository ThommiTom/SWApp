//
//  KeyValueLabel.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct KeyValueLabel: View {
    let key: String
    let value: String
    let font: Font

    init(key: String, value: String, font: Font = .caption) {
        self.key = key
        self.value = value
        self.font = font
    }

    var body: some View {
        HStack {
            Text(key)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
        .font(font)
    }
}

#Preview {
    KeyValueLabel(key: "Key", value: "Value", font: .body)
}
