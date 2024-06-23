//
//  ConfigurationManager.swift
//  NewsBoard
//
//  Created by Sachin Kadam on 23/06/24.
//

import Foundation

private enum BuildConfiguration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
    static var baseURL: String {
        do {
            return try BuildConfiguration.value(for: "BASE_URL")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static var newsAPIKey: String {
        do {
            return try BuildConfiguration.value(for: "NEWS_API_KEY")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

enum ConfigurationManager {
    enum Environment {
        case dev
        case qat
        case prod
    }
    
    static var environment: Environment {
        #if DEV
            return .dev
        #elseif QA
            return .qat
        #elseif PROD
            return .prod
        #endif
    }
}
