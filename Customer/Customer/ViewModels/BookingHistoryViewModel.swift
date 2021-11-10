//
//  BookingHistoryViewModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/11/2021.
//

import Foundation
import UIKit

class BookingHistoryViewModel {
    
    var bookings: Dynamic<[BookingHistoryModel]> = Dynamic([BookingHistoryModel]())
    
    func getBookingHistory(_ view: UIView?) {
        APIClient.callApi(api: .job, method: .get, view: view) { [weak self] data in
            if let dictionary = data {
                if let obj = ObjectMapperManager<BookingHistoryResponseModel>().map(dictionary: dictionary),
                   obj.success ?? false {
                    if let bookings = obj.bookings {
                        self?.bookings.value = bookings
                    }
                }
            }
        }
    }
    
}
