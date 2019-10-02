//
//  ViewController.swift
//  testApp
//
//  Created by John Green on 10/2/19.
//  Copyright © 2019 John Green. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableList: UITableView!
    let dataManager = DataManager()

    func setupTable(){
        tableList.delegate = self
        tableList.dataSource = self
    }

    func updateNavigationBar(){
        navigationItem.title = "HitsCount: \(dataManager.getDataCount())"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.updateData() {
            self.updateTable()
        }
        setupTable()
        updateNavigationBar()
    }
}

extension ViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableList.dequeueReusableCell(withIdentifier: dataManager.getCellIdentifier()) as? TableViewCell
        if cell == nil {
            cell = TableViewCell()
        }
        cell?.setupCell(title: dataManager.getData(id: indexPath.row).title ?? "Empty Title",
                        createdAt: dataManager.getData(id: indexPath.row).createdAt ?? "Empty Date",
                        text: dataManager.getData(id: indexPath.row).text ?? "Empty Text")
        return cell!
    }
    
    func updateTable() {
        DispatchQueue.main.async {
            self.tableList.reloadData()
            self.updateNavigationBar()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataManager.getDataCount() - 1 {
            if dataManager.getDataCount() < DataManager.recordsMaxCount {
                dataManager.updateData {
                    self.updateTable()
                }
            }
        }
    }
}
