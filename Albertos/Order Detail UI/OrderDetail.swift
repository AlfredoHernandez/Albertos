//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct OrderDetail: View {
    @ObservedObject var viewModel: OrderDetailViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(viewModel.headerText)
            if viewModel.orderedItems.isEmpty {
                Text(viewModel.emptyMenuFallbackText).multilineTextAlignment(.center)
            } else {
                List(viewModel.orderedItems) { Text($0.name) }
            }
            if let totalAmount = viewModel.totalAmmount {
                Text(totalAmount)
            }
            if viewModel.shouldShowCheckoutButton {
                Button {
                    viewModel.checkOut()
                } label: {
                    Text(viewModel.checkoutButtonText)
                        .font(Font.callout.bold())
                        .padding(12)
                        .foregroundColor(.white)
                        .background(Color.crimson)
                        .cornerRadius(10.0)
                }
            }
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
