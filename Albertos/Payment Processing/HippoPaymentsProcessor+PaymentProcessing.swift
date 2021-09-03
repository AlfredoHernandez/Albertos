//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine
import HippoPayments

extension HippoPaymentsProcessor: PaymentProcessing {
    func process(order _: Order) -> AnyPublisher<Void, Error> {
        Future { promise in
            self.processPayment(
                payload: ["itesm": ["Arancini Balls", "Penne all'Arrabbiata"]],
                onSuccess: { promise(.success(())) },
                onFailure: { promise(.failure($0)) }
            )
        }
        .eraseToAnyPublisher()
    }
}
