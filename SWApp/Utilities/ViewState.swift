//
//  ViewState.swift
//  SWApp
//
//  Created by Thomas Schatton on 18.11.23.
//

import Foundation

enum ViewState {
    case none
    case downloadingData
    case presentingData
    case presentDownloadError(Error)
}
