//
//  APIService.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import Foundation

class APIService {
    private let baseURL = "https://emotive-api.creteagency.com/api/"
    
    func sendRequest<T: Decodable>(
        endpoint: APIEndpoint,
        body: Encodable? = nil,
        method: HTTPMethod? = .GET,
        queryParams: [String: String]? = nil,
        appendString:String? = nil
    ) async -> Result<T, Error> {
        // Construct the base URL with endpoint
        var urlString = "\(baseURL)\(endpoint.path)"
        // If there are query parameters, append them to the URL
        if let queryParams = queryParams, !queryParams.isEmpty {
            var urlComponents = URLComponents(string: urlString)
            urlComponents?.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            urlString = urlComponents?.url?.absoluteString ?? urlString
        }
        if appendString != nil {
            urlString.append(appendString ?? "")
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method?.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        
        // Add body data if present
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Validate HTTP status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(response)
                let error = NSError(domain: "Invalid Response", code: (response as? HTTPURLResponse)?.statusCode ?? 500, userInfo: nil)
                return .failure(error)
            }
            
            // Decode JSON response
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)
            
        } catch {
            // Handle failure (network or decoding error)
            print("Request failed with error: \(error)")
            return .failure(error)
        }
    }
}
