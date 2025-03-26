//
//  ModelsViewModel.swift
//  Crete Task
//
//  Created by Mostfa Sobaih on 24/03/2025.
//

import Foundation
import Combine

class ModelsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isFetchingMore = false
    @Published var errorMessage: String?
    @Published var models: [Model] = []
    @Published var ads: [Ad] = []
    
    private let apiService = APIService()
    private var hasMoreData = true
    
    @MainActor
    func fetchModels(page: Int, brandId: Int, reset: Bool = false) async {
        guard !isLoading, !isFetchingMore, hasMoreData else { return }
        
        if reset {
            isLoading = true
        } else {
            isFetchingMore = true
        }
        
        errorMessage = nil
        
        let result: Result<ModelsResponse, Error> = await apiService.sendRequest(
            endpoint: .models,
            method: .GET,
            queryParams: ["category": "3",
                          "brand": "\(brandId)",
                          "page": "\(page)"]
        )
        
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                if reset {
                    self.models = response.data ?? []
                    self.ads = response.ads ?? []
                } else {
                    self.models.append(contentsOf: response.data ?? [])
                }
                self.hasMoreData = !(response.data?.isEmpty ?? true)
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            
            self.isLoading = false
            self.isFetchingMore = false
        }
    }
}
