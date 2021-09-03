//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine

protocol PaymentProcessing {
    func process(order: Order) -> AnyPublisher<Void, Error>
}
