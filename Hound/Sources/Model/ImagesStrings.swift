//
//  ImagesStrings.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Foundation

// MARK: - ImagesStringsResponse
struct ImagesStringsResponse: Codable {
    var message: [String]
    var status: String
}
// MARK: - MyHound
struct MyHound {
    var images: [String]
}
// MARK: - UserFavorite
final class UserFavorite {
    var hound: String!
    var imagesArray: [String]? {
        get {
            UserDefaults.standard.array(forKey: hound) as? [String]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: hound)
        }
    }
    func delete() {
        UserDefaults.standard.removeObject(forKey: hound)
    }
}
