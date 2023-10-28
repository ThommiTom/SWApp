//
//  FilmList.swift
//  SWApp
//
//  Created by Thomas Schatton on 28.10.23.
//

import Foundation

struct FilmList: Decodable {
    var count: Int = 0
    var results: [Film] = []
}
