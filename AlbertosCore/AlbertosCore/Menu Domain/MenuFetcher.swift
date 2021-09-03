//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Combine
import Foundation

public protocol NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError>
}

public class MenuFetcher: MenuFetching {
    let networkFetching: NetworkFetching

    public init(networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
    }

    public func fetchMenu() -> AnyPublisher<[MenuItem], Error> {
        let url = URL(string: "https://s3.amazonaws.com/mokacoding/menu_response.json")!
        return networkFetching
            .load(URLRequest(url: url))
            .decode(type: [MenuItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

extension URLSession: NetworkFetching {
    public func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        dataTaskPublisher(for: request)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
