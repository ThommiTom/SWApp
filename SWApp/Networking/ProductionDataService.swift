//
//  ProductionDataService.swift
//  SWApp
//
//  Created by Thomas Schatton on 15.10.23.
//

import Foundation
import Combine

// conformance to protocol DataServiceProtocol does not work
class ProductionDataService<Item: Decodable> {
    var model = [Item]()

    let group = DispatchGroup()
    let urls: [URL?]

    init(urls: [URL?]) {
        self.urls = urls
    }

    func fetchData() -> Future<[Item], Error> {
        Future { promise in
            self.fetchDataSets(urls: self.urls) { returnedValue in
                promise(.success(returnedValue))
            }
        }
    }

    private func fetchDataSets(urls: [URL?], completion: @escaping (_ data: [Item]) -> Void) {
        for url in urls {
            fetchDataSet(url: url)
        }

        group.notify(queue: DispatchQueue.main) {
            completion(self.model)
        }
    }

    private func fetchDataSet(url: URL?) {
        group.enter()
        Task {
            await NetworkManager.shared.networkCall(with: url) { (result: Result<Item, NetworkError>) in
                switch result {
                case .success(let item):
                    self.model.append(item)
                case .failure(let error):
                    print(error.rawValue)
                }

                self.group.leave()
            }
        }
    }
}
