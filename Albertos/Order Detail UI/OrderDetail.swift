//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct OrderDetail: View {
    let viewModel: OrderDetailViewModel

    var body: some View {
        Text(viewModel.headerText)
    }
}
