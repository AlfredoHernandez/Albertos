//
//  Copyright © 2021 Jesús Alfredo Hernández Alarcón. All rights reserved.
//

import Foundation

struct TestError: Equatable, Error {
    let id: Int
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}
