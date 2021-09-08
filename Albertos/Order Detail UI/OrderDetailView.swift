//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    @ObservedObject var viewModel: OrderDetailViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Capsule()
                .fill(Color.black)
                .frame(width: 140, height: 5, alignment: .center)
            Text(viewModel.headerText)
                .font(.title)
                .fontWeight(.heavy)
            if viewModel.orderedItems.isEmpty {
                Spacer()
                VStack {
                    Image(systemName: "bag")
                        .font(.system(size: 180))
                        .foregroundColor(.accentColor)
                    Text(viewModel.emptyMenuFallbackText)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                List(viewModel.orderedItems) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("$ \(String(format: "%.2f", item.price))")
                    }
                }.listStyle(PlainListStyle())
            }
            HStack(alignment: .center) {
                if let totalAmount = viewModel.totalAmmount {
                    Text(totalAmount)
                        .fontWeight(.bold)
                }
                Spacer()
                if viewModel.shouldShowCheckoutButton {
                    Button {
                        viewModel.checkOut()
                    } label: {
                        Text(viewModel.checkoutButtonText)
                            .font(Font.callout.bold())
                            .padding(12)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(10.0)
                    }
                }
            }.padding()
            Spacer()
        }
        .alert(item: $viewModel.alertToShow) { alertViewModel in
            Alert(
                title: Text(alertViewModel.title),
                message: Text(alertViewModel.message),
                dismissButton: .default(Text(alertViewModel.buttonText), action: alertViewModel.buttonAction)
            )
        }
        .padding(8)
    }
}

// import AlbertosCore
//
// struct OrderDetailView_Preview: PreviewProvider {
//    static var previews: some View {
//        OrderDetailView(viewModel: .init(
//            // orderController: OrderController(order: Order(items: [MenuItem(category: "category", name: "This is a new dish", spicy: true, price: 10)])),
//            orderController: OrderController(),
//            paymentProcessor: PaymentProcessingProxy(),
//            onAlertDismiss: {}
//        ))
//    }
// }
