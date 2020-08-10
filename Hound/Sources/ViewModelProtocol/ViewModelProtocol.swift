//
//  ViewModelProtocol.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
    
    var breeds: [Dictionary<String, [String]>.Element]? { get set }
    var imagesString: ImagesStrings? { get set }
    
    func getList(onSuccess: (()->Void)?)
    func getImagesStrings(breed: String, onSuccess: ((String)->Void)?)
}
