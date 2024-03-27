//
//  AppVersionCheck.swift
//  Gutter
//
//  Created by Dev Team on 30/10/23.
//

import Foundation

class VersionCheck {
    
    public static let shared = VersionCheck()
    
    func isUpdateAvailable(completion: @escaping (Bool?, String?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                throw VersionError.invalidBundleInfo
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw VersionError.invalidResponse
                }
                completion(version != currentVersion, identifier, nil)
            } catch {
                completion(nil,nil, error)
            }
        }
        task.resume()
        return task
    }
    
    enum VersionError: Error {
        case invalidResponse, invalidBundleInfo
    }

}

