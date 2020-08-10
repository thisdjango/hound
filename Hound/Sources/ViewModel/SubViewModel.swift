//
//  SubViewModel.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import RxSwift
import Moya

class SubViewModel: SubViewModelProtocol {
    // MARK: - Private Properties
    private let provider = MoyaProvider<Service>()
    // MARK: - Public Properties
    var breed: String?
    var subbreeds: [String]?
    var imagesString: ImagesStrings?
    // MARK: - Public Funcs
    func getSubbreedImages(subbreed: String, onSuccess: ((String)->Void)?) {
        _ = provider.rx.request(.getSubbreedImages(breed: breed ?? "hound", subbreed: subbreed)).subscribe { event in
                switch event {
                case let .success(response):
                    if let data = try? response.map(ImagesStrings.self) {
                        onSuccess?(data.message[0])
                    }
                case let .error(error):
                    print(error)
                }
        }
    }
}
