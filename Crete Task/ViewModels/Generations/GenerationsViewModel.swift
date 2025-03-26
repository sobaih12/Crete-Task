//
//  GenerationsViewModel.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 25/03/2025.
//

import Foundation
import Combine

class GenerationsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isFetchingMore = false
    @Published var errorMessage: String?
    @Published var cars: [Car] = []
    
    private let apiService = APIService()
    
    @MainActor
    func fetchGenerations(brandId: Int,identificationAttributeId: Int,identificationAttributeValueId: Int) async{
        
        isLoading = true
        errorMessage = nil
        
        let result: Result<GenerationsResponse, Error> = await apiService.sendRequest(
            endpoint: .generations,
            method: .GET,
            queryParams: ["category": "3",
                          "brand": "\(brandId)",
                          "identification_attribute_id": "\(identificationAttributeId)",
                          "identification_attribute_value_id": "\(identificationAttributeValueId)"]
        )
        
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                self.cars = response.data ?? []
                self.isLoading = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
}
