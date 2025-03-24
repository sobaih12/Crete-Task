//
//  APIEndpoint.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//


enum APIEndpoint: String {
    case brands = "brands"

    
    
    var path: String {
        return self.rawValue
    }
}
