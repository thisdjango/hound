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
    var myHound: MyHound?
    // MARK: - Public Funcs
    func getSubbreedImages(subbreed: String, onSuccess: ((MyHound)->Void)?) {
        _ = provider.rx.request(.getSubbreedImages(breed: breed ?? "hound", subbreed: subbreed)).subscribe { event in
                switch event {
                case let .success(response):
                    if let data = try? response.map(ImagesStringsResponse.self) {
                        self.myHound = MyHound(images: data.message)
                        print(data.status)
                        print(data.message)
                        if let myHound = self.myHound { onSuccess?(myHound) }
                    }
                case let .error(error):
                    print(error)
                }
        }
    }
}
