//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct OrderButton: View {
    @EnvironmentObject var orderController: OrderController
    let viewModel: OrderButtonViewModel

    @State private(set) var showingDetail: Bool = false

    var body: some View {
        Button {
            self.showingDetail.toggle()
        } label: {
            Text(viewModel.text)
                .font(Font.callout.bold())
                .padding(12)
                .foregroundColor(.white)
                .background(Color.crimson)
                .cornerRadius(10.0)
        }
        .sheet(isPresented: $showingDetail) {
            OrderDetail(viewModel: .init())
        }
    }
}
