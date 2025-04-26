//
//  HomeViewModal.swift
//  BookxpertAssignmentProject
//
//  Created by Sadaf Khan on 26/04/25.
//

import Foundation

class HomeViewModal {
    
    func performRequest(with urlString: String, completion: @escaping (Result<[HomeDataModel], Error>) -> ()) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                
                if let safeData = data {
                    if let deviceDetails = self.parseJSON(safeData) {
                        completion(.success(deviceDetails))
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ deviceData: Data) -> [HomeDataModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([HomeDataModel].self, from: deviceData)
            return decodedData
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
