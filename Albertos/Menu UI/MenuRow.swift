//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import SwiftUI

struct MenuRow: View {
    let item: MenuRowViewModel

    var body: some View {
        Text(item.text)
    }
}
