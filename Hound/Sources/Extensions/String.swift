//
//  String.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        let first = prefix(1).capitalized
        let other = dropFirst()
        return first + other
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
