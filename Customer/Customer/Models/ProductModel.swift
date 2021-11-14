
import Foundation
import ObjectMapper

class OrderInfo: Mappable {
    
    var orderId: Int?
    var price: String?
    var productId: Int?
    var quantity: String?
    
    var displayQuantity: String {
        return "Qty:\((quantity ?? "0"))"
    }
    
    var displayPrice: String {
        let amountStr = self.price ?? "0"
        let amount: Double = Double(amountStr) ?? 0
        let amountInt = Helper.formatCurrency(value: amount) ?? "0"
        return "Rs. " + amountInt
    }
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        orderId <- map["order_id"]
        price <- map["price"]
        productId <- map["product_id"]
        quantity <- map["qty"]
    }
}

class ProductModel: Mappable {
    
	var id : Int?
	var name : String?
	var description : String?
	var longDescription : String?
	var price : Int?
	var isFeatured : Int?
	var stockAvailable : Int?
	var rating : Double?
	var status : Int?
    var images: [ImageModel]?
    var orderInfo: OrderInfo?
	var createdBy : Int?
	var updatedBy : Int?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?
    
    var displayFormattedDate: String {
        if let cAt = self.createdAt {
            return cAt.toFormattedDate(format: .standardFormat) ?? "NA"
        }
        return "NA"
    }
    
    var displayPrice: String {
        let amount = self.price ?? 0
        let amountInt = Helper.formatCurrency(value: amount) ?? "0"
        return "Rs. " + amountInt
    }
    
    var quantity: Int = 0
    var displayQuantity: String {
        return "Qty:\(quantity)"
    }

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		description <- map["description"]
		longDescription <- map["long_description"]
		price <- map["price"]
		isFeatured <- map["is_featured"]
		stockAvailable <- map["stock_available"]
		rating <- map["rating"]
		status <- map["status"]
        images <- map["images"]
        orderInfo <- map["order_info"]
		createdBy <- map["created_by"]
		updatedBy <- map["updated_by"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
	}

}

extension ProductModel: Equatable {
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
