//
//  DataService.swift
//  SportPoint
//
//  Created by Aksilont on 09.03.2023.
//

import Foundation

final class DataService {
    static func fectData(completion: @escaping (Result<[Point], APIError>) -> Void) {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let result = try JSONDecoder().decode([Point].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodeError))
            }
        } else { return completion(.failure(.dataNotFound)) }
    }
}
