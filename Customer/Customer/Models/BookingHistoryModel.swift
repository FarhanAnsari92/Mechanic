//
//  BookingHistoryModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 09/11/2021.
//

import ObjectMapper

class BookingHistoryResponseModel: Mappable {
    
    var message: String?
    var success: Bool?
    var bookings: [BookingHistoryModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        success <- map["success"]
        bookings <- map["data.data"]
    }
}

class BookingHistoryModel: Mappable {
    
    var id: Int?
    var address: String?
    var city: CityModel?
    var services: [Service]?
    var vehicle: GetVehicleModel?
    var jobNumber: String?
    var jobStatus: String?
    var jobType: String?
    var numberPlate: String?
    var paymentStatus: String?
    var paymentType: String?
    var totalAmount: String?
    var createdAt: String?
    var user: UserModel?
    
    var displayBookingId: String {
        if let bId = self.id {
            return "Booking ID: \(bId.description)"
        }
        return "Booking ID: N/A"
    }
    
    var brandName: String {
        return self.vehicle?.brand?.title ?? "NA"
    }
    
    var horsePower: String {
        return self.vehicle?.horsePower ?? "NA"
    }
    
    var year: String {
        return (self.vehicle?.year ?? 0).description + "HP"
    }
    
    var cityName: String {
        return self.city?.name ?? "NA"
    }
    
    var vehicleTitle: String {
        return self.vehicle?.vehicle?.name ?? "NA"
    }
    
    var vehicleName: String {
        return "Vehicle: " + vehicleTitle
    }
    
    var charges: String {
        let amount = self.totalAmount ?? "0"
        let amountInt = Helper.formatCurrency(value: Int(amount)) ?? "0"
        return "Rs. " + amountInt
    }
    
    var bookingCreatedAt: String {
        if let cAt = self.createdAt {
            return cAt.toFormattedDate(format: .standardFormat) ?? "--"
        }
        return "--"
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        city <- map["city"]
        services <- map["job_services"]
        jobNumber <- map["job_number"]
        jobStatus <- map["job_status"]
        jobType <- map["job_type"]
        numberPlate <- map["number_plate"]
        paymentStatus <- map["payment_status"]
        paymentType <- map["payment_type"]
        totalAmount <- map["total_amount"]
        vehicle <- map["vehicle"]
        id <- map["id"]
        createdAt <- map["created_at"]
        user <- map["user"]
    }
}
