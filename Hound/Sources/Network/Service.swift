//
//  Service.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Moya

enum Service {
    case getList
    case getImagesString(breed: String)
    case getSubbreedImages(breed: String, subbreed: String)
}

extension Service: TargetType {

    var baseURL: URL {
     URL(string: "https://dog.ceo/api")!
    }

    var path: String {
        switch self {
        case .getList:
            return "/breeds/list/all"
        case .getImagesString(let breed):
            return "/breed/\(breed)/images"
        case .getSubbreedImages(let breed, let subbreed):
            return "/breed/\(breed)/\(subbreed)/images/"
        }
    }

    var method: Method {
        switch self {
        case .getList, .getImagesString, .getSubbreedImages:
            return .get
        }
    }
    
    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        ["Content-type": "application/json"]
    }

    var sampleData: Data {
        Data()
    }
}
