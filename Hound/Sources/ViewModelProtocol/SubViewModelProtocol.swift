//
//  SubViewModelProtocol.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Foundation

protocol SubViewModelProtocol: class {
    var breed: String? { get set }
    var subbreeds: [String]? { get set }
    var imagesString: ImagesStrings? { get set }
    
    func getSubbreedImages(subbreed: String, onSuccess: ((String)->Void)?)
}
