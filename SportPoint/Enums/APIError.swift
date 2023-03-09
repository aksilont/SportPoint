//
//  APIError.swift
//  SportPoint
//
//  Created by Aksilont on 09.03.2023.
//

import Foundation

enum APIError: Error {
    case dataNotFound
    case decodeError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Данные не найдены"
        case .decodeError:
            return "Ошибка получения данных"
        }
    }
}
