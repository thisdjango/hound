//
//  Breeds.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Foundation

// MARK: - Breeds
struct BreedsResponse: Codable {
    var message: [String: [String]]
    var status: String
}
