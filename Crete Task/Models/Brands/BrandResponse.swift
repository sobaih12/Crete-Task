//
//  BrandResponse.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

struct BrandsResponse: Codable {
    let data: [Brand]?
}

struct Brand: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
