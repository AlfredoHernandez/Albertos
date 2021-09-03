//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import AlbertosCore
import Combine
import Foundation

class MenuFetcherSpy {
    var publishers = [PassthroughSubject<[MenuItem], Error>]()

    func publisher() -> AnyPublisher<[MenuItem], Error> {
        let publisher = PassthroughSubject<[MenuItem], Error>()
        publishers.append(publisher)
        return publisher.eraseToAnyPublisher()
    }

    func complete(with menuItems: [MenuItem], at index: Int = 0) {
        publishers[index].send(menuItems)
        publishers[index].send(completion: .finished)
    }

    func complete(with error: Error, at index: Int = 0) {
        publishers[index].send(completion: .failure(error))
    }
}
