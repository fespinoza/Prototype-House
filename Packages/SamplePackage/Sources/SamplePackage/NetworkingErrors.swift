//
//  File.swift
//  
//
//  Created by Felipe Espinoza on 06/07/2023.
//

import Foundation

public enum NetworkingError: LocalizedError, CaseIterable {
    case clientError
    case serverError
    case authorizationError
    case codingError

    public var errorDescription: String? {
        switch self {
        case .clientError:
            return String(localized: "Client Error", bundle: .module)
        case .serverError:
            return String(localized: "Server Error", bundle: .module)
        case .authorizationError:
            return String(localized: "Authorization Error", bundle: .module)
        case .codingError:
            return NSLocalizedString("Coding Error", bundle: .module, comment: "sample coding error")
        }
    }
}
