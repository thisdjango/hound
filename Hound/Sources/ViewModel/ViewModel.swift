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
    private let provider = MoyaProvider<Service>()
    // MARK: - Public Properties
    var breeds: [Dictionary<String, [String]>.Element]?
    var imagesString: ImagesStrings?
    // MARK: - Public Methods
    func getList(onSuccess: (()->Void)?) {
        _ = provider.rx.request(.getList).subscribe { [weak self] event in
                switch event {
                case let .success(response):
                    if let data = try? response.map(Breeds.self) {
                        self?.breeds = data.message.sorted(by: { $0.key < $1.key })
                        onSuccess?()
                    }
                case let .error(error):
                    print(error)
                }
        }
    }
    
    func getImagesStrings(breed: String, onSuccess: ((String)->Void)?) {
        _ = provider.rx.request(.getImagesString(breed: breed)).subscribe { event in
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
