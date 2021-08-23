//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

@testable import Albertos
import Combine
import Foundation

class NetworkFetchingStub: NetworkFetching {
    private let result: Result<Data, URLError>

    init(returning result: Result<Data, URLError>) {
        self.result = result
    }

    func load(_: URLRequest) -> AnyPublisher<Data, URLError> {
        result.publisher
            .delay(for: 0.01, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
