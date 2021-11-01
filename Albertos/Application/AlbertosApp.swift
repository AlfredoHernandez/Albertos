//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import Combine
import SwiftUI

let menuFectherLoader = URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://s3.amazonaws.com/mokacoding/menu_response.json")!)
    .map(\.data)
    .decode(type: [MenuItem].self, decoder: JSONDecoder())
    .eraseToAnyPublisher()

@main
struct AlbertosApp: App {
    let orderController = OrderController()
    let paymentProcessor = PaymentProcessingProxy()

    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                NavigationView {
                    MenuListView(
                        viewModel: .init(
                            menuFetcher: menuFectherLoader,
                            menuGroupingStrategy: groupMenuByCategory
                        ),
                        orderController: orderController
                    )
                    .navigationTitle("Alberto's 🇮🇹")
                }
                OrderButton(
                    orderDetailView: { onComplete in
                        OrderDetailView(viewModel: .init(
                            orderHandler: orderController,
                            paymentProcessor: paymentProcessor,
                            onAlertDismiss: onComplete
                        ))
                    },
                    viewModel: .init(orderController: orderController)
                ).padding(16)
            }
            .environmentObject(paymentProcessor)
        }
    }
}
