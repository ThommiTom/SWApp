//
//  DataServiceProtocol.swift
//  SWApp
//
//  Created by Thomas Schatton on 15.10.23.
//

import Foundation
import Combine

protocol DataServiceProtocol {
    associatedtype Item: Decodable
    func fetchData() -> Future<[Item], Error>
}
