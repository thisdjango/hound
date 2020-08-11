//
//  FavoriteViewController.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class FavoriteViewController: ViewController {
    // MARK: - Private Properties
    private let viewModel = FavoriteViewModel()

    // MARK: - Override Methods
    override func configureUI() {
        super.configureUI()
        title = "Favourites"
    }
}
