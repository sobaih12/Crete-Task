//
//  ModelsResponse.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import Foundation

struct ModelsResponse: Codable {
    let data: [Model]?
    let ads: [Ad]?
}

struct Model: Codable, Identifiable,Hashable {
    let id: Int?
    let vehicleID: Int?
    let name: String?
    let image: String?
    let leastDeposit: Double?
    let leastInstallment: Double?
    let identificationAttributeID: Int?
    let identificationAttributeValueID: Int?
    let attribute: String?
    let attributeImage: String?
    let attributeValue: String?
    let price: Int?
    let hiddenPrice: Int?
    let parentBrand: String?
    let parentBrandImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case vehicleID = "vehicle_id"
        case name, image
        case leastDeposit = "least_deposit"
        case leastInstallment = "least_installment"
        case identificationAttributeID = "identification_attribute_id"
        case identificationAttributeValueID = "identification_attribute_value_id"
        case attribute
        case attributeImage = "attribute_image"
        case attributeValue = "attribute_value"
        case price
        case hiddenPrice = "hidden_price"
        case parentBrand = "parent_brand"
        case parentBrandImage = "parent_brand_image"
    }
}

// MARK: - Attribute Hint Model
struct AttributeHint: Codable {
    let attribute: String?
    let image: String?
    let value: String?
}

// MARK: - Ad Model
struct Ad: Codable {
    let id: Int?
    let image: String?
    let url: String?
    let position: Int?
}
