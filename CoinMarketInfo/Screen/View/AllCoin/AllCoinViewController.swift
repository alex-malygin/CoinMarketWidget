//
//  AllCoinViewController.swift
//  CoinMarketInfo
//
//  Created by Eugene Shapovalov on 21.02.2021.
//

import UIKit
import Combine

class AllCoinViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = AllCoinListViewModel()
    private var subscriptions = Set<AnyCancellable>()
    private var coinCell = "coinCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.observCoinData()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CoinTableViewCell", bundle: nil), forCellReuseIdentifier: coinCell)
        viewModel.dataSource.sink { [unowned self] _ in
            self.tableView.reloadData()
        }.store(in: &subscriptions)
    }
}

extension AllCoinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: coinCell, for: indexPath) as! CoinTableViewCell
        let cellModel = viewModel.dataSource.value[indexPath.row]
        cell.config(cellModel)
        
        return cell
    }
}

