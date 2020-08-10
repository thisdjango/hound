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
        
        viewModel.getSubbreedImages(subbreed: viewModel.subbreeds?[indexPath.row] ?? "afghan") { string in
            vc.imageString = string
            print("list images for subbreeds got")
        }
        
        vc.title = viewModel.imagesString?.message[indexPath.row].capitalizingFirstLetter()
        navigationController?.pushViewController(vc, animated: true)
    }
}