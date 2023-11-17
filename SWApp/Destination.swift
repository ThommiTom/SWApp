//
//  Destination.swift
//  SWApp
//
//  Created by Thomas Schatton on 17.11.23.
//

import SwiftUI

protocol Destination: Hashable, Identifiable, View {}

extension Destination {
    // Identifiable conformance
    var id: String { String(describing: self) }
}
