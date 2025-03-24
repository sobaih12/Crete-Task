//
//  BrandsViewModel.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import Foundation
import Combine

class BrandsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var brands: [Brand] = []
    @Published var filteredBrands: [Brand] = []
    @Published var searchText: String = "" {
        didSet {
            filterBrands()
        }
    }
    private let apiService = APIService()
    
    @MainActor
    func fetchBrands() async {
        isLoading = true
        errorMessage = nil
        
        let result: Result<BrandsResponse, Error> = await apiService.sendRequest(
            endpoint: .brands,
            method: .GET,
            queryParams: ["category": "3"]
        )
        
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                self.brands = response.data ?? []
                self.filterBrands()
                self.isLoading = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    private func filterBrands() {
        if searchText.isEmpty {
            filteredBrands = brands
        } else {
            filteredBrands = brands.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
}
