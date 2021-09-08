//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import AlbertosCore
import SwiftUI

struct OrderButton: View {
    let orderController: OrderHandler
    @EnvironmentObject var paymentProcessor: PaymentProcessingProxy
    @ObservedObject var viewModel: OrderButtonViewModel

    @State private(set) var showingDetail: Bool = false

    var body: some View {
        Button {
            self.showingDetail.toggle()
        } label: {
            Text(viewModel.text)
                .frame(maxWidth: .infinity)
                .font(Font.callout.bold())
                .padding(12)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(10.0)
        }
        .shadow(radius: 8)
        .sheet(isPresented: $showingDetail) {
            OrderDetailView(viewModel: .init(
                orderHandler: orderController,
                paymentProcessor: paymentProcessor,
                onAlertDismiss: { self.showingDetail = false }
            ))
        }
    }
}
