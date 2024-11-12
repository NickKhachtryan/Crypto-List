//
//  ViewController.swift
//  Crypto List
//
//  Created by Nick Khachatryan on 11.11.2024.
//

import UIKit

class HomeController: UIViewController {
    
    
    //MARK: - PROPERTIES
    private let coins = Coin.getMockArray()
    
    
    //MARK: - UI COMPONENTS
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - VC LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    //MARK: - CONSTRAINTS
    
    private func setupUI() {
        navigationItem.title = "CryptoList"
//        view.backgroundColor = .green

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }
    
    //MARK: - SELECTORS
    


}

//MARK: - TABLEVIEW FUNCTIONS

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else { fatalError("error") }
        
        let coin = coins[indexPath.row]
        
        Task {
            await cell.configure(with: coin)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coin = coins[indexPath.row]
        let vm = ViewCryptoControllerViewModel(coin)
        let vc = ViewCryptoController(vm)
        navigationController?.pushViewController(vc, animated: true)

    }
    
}
