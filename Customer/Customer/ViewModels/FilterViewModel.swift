//
//  FilterViewModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 21/11/2021.
//

import Foundation

class Filter: Equatable {
    
    var filterTitle: String
    var isSelected: Bool
    var minPrice: Int
    var maxPrice: Int
    
    init(filterTitle: String, isSelected: Bool, minPrice: Int, maxPrice: Int) {
        self.filterTitle = filterTitle
        self.isSelected = isSelected
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.filterTitle == rhs.filterTitle
    }
}

class FilterViewModel {
    
    var filters: Dynamic<[Filter]> = Dynamic([Filter]())
    
    func getData() {
        var _filters = [Filter]()
        _filters.append(Filter(filterTitle: "Recommended (Default)", isSelected: true, minPrice: 0, maxPrice: 0))
        _filters.append(Filter(filterTitle: "Price Low To High", isSelected: false, minPrice: 0, maxPrice: 0))
        _filters.append(Filter(filterTitle: "Price High To Low", isSelected: false, minPrice: 0, maxPrice: 0))
        _filters.append(Filter(filterTitle: "Top Rated", isSelected: false, minPrice: 0, maxPrice: 0))
        _filters.append(Filter(filterTitle: "Ascending (A-Z)", isSelected: false, minPrice: 0, maxPrice: 0))
        _filters.append(Filter(filterTitle: "Descending (Z-A)", isSelected: false, minPrice: 0, maxPrice: 0))
        self.filters.value = _filters
    }
    
    func setActive(filter: Filter) {
        self.filters.value.forEach({ $0.isSelected = false })
        let temp = self.filters.value
        temp.filter({ $0 == filter }).first?.isSelected.toggle()
        self.filters.value = temp
    }
    
}
