//
//  FavoriteViewModel.swift
//  Hound
//
//  Created by Diana Tsarkova on 11.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import Moya
import RxSwift

class FavoriteViewModel: ViewModel {
    // MARK: - Private Properties
    private let provider = MoyaProvider<Service>(plugins: [NetworkLoggerPlugin()])
    // MARK: - Public Methods
    override func getList(onSuccess: (()->Void)?) {
        _ = provider.rx.request(.getList).subscribe { [weak self] event in
                switch event {
                case let .success(response):
                    if let data = try? response.map(BreedsResponse.self) {
                        var sort = [Dictionary<String, [String]>.Element]()
                        data.message.forEach {
                            if let data = UserDefaults.standard.array(forKey: $0.key) as? [String] {
                                sort.append(contentsOf: Dictionary(dictionaryLiteral: ($0.key, data)))
                            }
                        }
                        self?.breeds = sort.sorted(by: { $0.key < $1.key })
                        print(data.status)
                        onSuccess?()
                    }
                case let .error(error):
                    print(error)
                }
        }
    }
}
