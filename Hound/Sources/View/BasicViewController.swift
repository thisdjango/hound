//
//  BasicViewController.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController, Configurable {
    // MARK: - Public Property
    var tableView = UITableView()
    var onSelectRow: (() -> Void)?
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubviews()
        configureHandlers()
    }
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Public Funcs
    func configureUI() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
    }
    func configureSubviews() {
        view.addSubview(tableView.prepareLayout())
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.pin()
    }
    func configureHandlers() {}
}
