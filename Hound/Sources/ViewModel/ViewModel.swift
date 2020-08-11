//
//  ViewModel.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Moya
import RxSwift

class ViewModel: ViewModelProtocol {
    // MARK: - Private Properties
    private let provider = MoyaProvider<Service>(plugins: [NetworkLoggerPlugin()])
    // MARK: - Public Properties
    var breeds: [Dictionary<String, [String]>.Element]?
    var myHound: MyHound?
    // MARK: - Public Methods
    func getList(onSuccess: (()->Void)?) {
        _ = provider.rx.request(.getList).subscribe { [weak self] event in
                switch event {
                case let .success(response):
                    if let data = try? response.map(BreedsResponse.self) {
                        self?.breeds = data.message.sorted(by: { $0.key < $1.key })
                        print(data.status)
                        onSuccess?()
                    }
                case let .error(error):
                    print(error)
                }
        }
    }
    
    func getImagesStrings(breed: String, onSuccess: ((MyHound)->Void)?) {
        _ = provider.rx.request(.getImagesString(breed: breed)).subscribe { event in
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
