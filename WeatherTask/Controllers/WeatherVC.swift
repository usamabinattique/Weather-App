//
//  ViewController.swift
//  WeatherTask
//
//  Created by usama on 02/03/2022.
//

import UIKit

class WeatherVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: WeatherViewModel!

    // MARK: UIController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension WeatherVC {
    func setupUI() {
        
        viewModel = WeatherViewModel()
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.tableFooterView =  UIView()
        tableView.dataSource = self
    }
}

extension WeatherVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

