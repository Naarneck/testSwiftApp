//
//  DataAPIHandler.swift
//  testApp
//
//  Created by John Green on 10/2/19.
//  Copyright © 2019 John Green. All rights reserved.
//

import Foundation

class DataAPIHandler {
    let request = "https://hn.algolia.com/api/v1/search_by_date?tags=story"

    func getData(page: Int, completion:@escaping (DataStruct?, Error?)->()) {
        let pageRequest = "\(request)&page=\(page)"

        guard let url = URL(string: pageRequest) else {
            print("Error while getting response from hn.algolia.com")
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) {
            data, response, error in
            if let data = data {
                do {
                    let json: DataStruct = try JSONDecoder().decode(DataStruct.self, from: data)
                    completion(json, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
