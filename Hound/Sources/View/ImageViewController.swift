//
//  ImageViewController.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit
import Kingfisher

class ImageViewController: UIViewController, UICollectionViewDelegate {
    // MARK: - Public Properties
    var data: MyHound?

    // MARK: - Private Properties
    private var collectionView: UICollectionView!
    private var imageHandler: (()->Void)?
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
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    // MARK: - Private Methods
    private func configureUI() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(shareAction))

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 42)
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.cellId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView.prepareLayout())
        collectionView.pin(view: view)
    }

    // MARK: - Objc Methods
    @objc func shareAction() {
        imageHandler?()
    }
}

extension ImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.images.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.cellId, for: indexPath) as? ImageViewCell {
            if let title = title, let data = data {
                cell.onTapLike = { [weak self] add in
                    let fav = UserFavorite()
                    fav.hound = title
                    if !(fav.imagesArray?.contains(data.images[indexPath.row]) ?? false) {
                        fav.imagesArray?.append(data.images[indexPath.row])
                    } else { fav.delete() }
                    self?.collectionView.reloadData()
                }
                
                cell.configureImage(image: data.images[indexPath.row]) { [weak self] image in
                    self?.imageHandler = {
                        if let image = image {
                            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                            activityViewController.popoverPresentationController?.sourceView = self?.view
                            self?.present(activityViewController, animated: true, completion: nil)
                        }
                    }
                }

            }
            return cell
        } else { return UICollectionViewCell() }
    }
    
}
