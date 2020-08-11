//
//  ImageViewCell.swift
//  Hound
//
//  Created by Diana Tsarkova on 11.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit
import Kingfisher

class ImageViewCell: UICollectionViewCell {
    static var cellId = "image"
    var onTapLike: ((Bool)->Void)?
    var likeCount = 0
    private let imageView = UIImageView()
    private let likeButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView.prepareLayout())
        addSubview(likeButton.prepareLayout())
        imageView.pin(const: [100, 100, 0, 0], view: self)
        imageView.contentMode = .scaleAspectFit
        
        likeButton.pin(to: [.right, .bottom], const: [0, 20, 0, 20], view: self)
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func likeAction() {
        
        configureLike()
    }
    private func configureLike() {
        likeCount += 1
        onTapLike?(!(likeCount % 2 == 0))
        if !(likeCount % 2 == 0) {
            likeButton.setImage(UIImage(named: "heart-fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    // MARK: - Public Funcs
    func configureImage(image: String, completionHandler: @escaping ((UIImage?)->())) {
        if let url = URL(string: image) {
            var options: KingfisherOptionsInfo = []
            options.append(.forceRefresh)
            options.append(.transition(ImageTransition.fade(1)))
            imageView.kf.setImage(with: url, options: options, completionHandler: { (image, error, cacheType, imageURL) in
                completionHandler(image)
            })
        }
    }
}
