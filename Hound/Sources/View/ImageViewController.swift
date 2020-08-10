//
//  ImageViewController.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit
import Kingfisher

class ImageViewController: UIViewController {
    // MARK: - Public Properties
    var imageString: String? {
        didSet {
            if let string = imageString {
                let url = URL(string: string)
                imageView.kf.setImage(with: url)
            }
        }
    }
    // MARK: - Private Properties
    private let imageView = UIImageView()
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    // MARK: - Private Methods
    private func configureUI() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        view.addSubview(imageView.prepareLayout())
        imageView.pin(const: [100, 100, 0, 0], view: view)
        imageView.contentMode = .scaleAspectFit
    }
}
