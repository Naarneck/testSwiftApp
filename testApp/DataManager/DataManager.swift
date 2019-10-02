//
//  DataManager.swift
//  testApp
//
//  Created by John Green on 10/2/19.
//  Copyright © 2019 John Green. All rights reserved.
//

import Foundation

struct CellData {
    var title: String?
    var createdAt: String?
    var text: String?
}

class DataManager {
    var recordsData: [CellData] = []
    let cellIdentifier = "list_cell"
    static let recordsMaxCount = 100
    //temp
    static let recordsPerPage = 20
    var currentPage = 1
    
    
    func updateData(completion:@escaping()->()) {
        DataAPIHandler().getData(page: currentPage) {
            json, error in
            for index in 0 ..< DataManager.recordsPerPage {
                let cellData = CellData(title: json?.hits?[index].title,
                                        createdAt: json?.hits?[index].createdAt,
                                        text: json?.hits?[index].highlightResult?.title?.value)
                self.recordsData.append(cellData)
            }
            self.currentPage += 1
            completion()
        }
    }

    func getDataCount() -> Int {
        return recordsData.count
    }
    
    func getData(id: Int) -> CellData {
        return recordsData[id]
    }
    
    func getCellIdentifier() -> String {
        return cellIdentifier
    }
}
