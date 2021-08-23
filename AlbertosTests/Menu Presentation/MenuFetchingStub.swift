//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import Combine
import Foundation

class MenuFetcherStub: MenuFetching {
    let result: Result<[MenuItem], Error>

    init(returning result: Result<[MenuItem], Error>) {
        self.result = result
    }

    func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        result
            .publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
