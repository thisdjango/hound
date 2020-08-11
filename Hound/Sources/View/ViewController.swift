//
//  ViewController.swift
//  Hound
//
//  Created by Diana Tsarkova on 07.08.2020.
//  Copyright © 2020 Diana Tsarkova. All rights reserved.
//

import UIKit

class ViewController: BasicViewController {
    // MARK: - Private Properties
    private let viewModel: ViewModelProtocol = ViewModel()

    // MARK: - Override Methods
    override func configureUI() {
        super.configureUI()
        title = "Breeds"
    }
    override func configureHandlers() {
        viewModel.getList { [weak self] in
            self?.tableView.reloadData()
        }
    }
    override func configureSubviews() {
        super.configureSubviews()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.breeds?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Formatting data
        if let data = viewModel.breeds {
            let key = data[indexPath.row].key
            var subbreeds = ""
            if !data[indexPath.row].value.isEmpty { subbreeds = " (\(data[indexPath.row].value.count) subbreeds)" }
            cell.textLabel?.text = key.capitalizingFirstLetter() + subbreeds
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = viewModel.breeds {
            // Does subbreed exist?
            let key = data[indexPath.row].key
            if !data[indexPath.row].value.isEmpty {
                let vc = SubViewController()
                
                vc.viewModel.subbreeds = data[indexPath.row].value
                vc.viewModel.breed = key
                
                vc.title = key.capitalizingFirstLetter()
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = ImageViewController()
                viewModel.getImagesStrings(breed: key) { data in
                    vc.data = data
                    vc.title = key.capitalizingFirstLetter()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

