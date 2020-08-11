//
//  SubViewController.swift
//  Hound
//
//  Created by Diana Tsarkova on 08.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class SubViewController: BasicViewController {
    // MARK: - Public Properties
    let viewModel: SubViewModelProtocol = SubViewModel()
    // MARK: - Override Methods
    override func configureUI() {
        super.configureUI()

    }
    override func configureSubviews() {
        super.configureSubviews()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

extension SubViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.subbreeds?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Formatting data
        if let data = viewModel.subbreeds {
            let key = data[indexPath.row]
            cell.textLabel?.text = key.capitalizingFirstLetter()
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        return cell
    }
    
}

extension SubViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ImageViewController()
        
        viewModel.getSubbreedImages(subbreed: viewModel.subbreeds?[indexPath.row] ?? "afghan") { data in
            vc.data = data
            vc.title = self.viewModel.subbreeds?[indexPath.row].capitalizingFirstLetter()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
