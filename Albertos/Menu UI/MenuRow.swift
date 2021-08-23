//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct MenuRow: View {
    let viewModel: MenuRowViewModel

    var body: some View {
        Text(viewModel.text)
    }
}
