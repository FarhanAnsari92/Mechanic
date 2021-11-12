
import Foundation
import ObjectMapper

class OrderModel: Mappable {
	var id : Int?
	var userId : Int?
	var reference : String?
	var addressId : Int?
	var address : String?
	var cityId : Int?
	var latitude : Double?
	var longitude : Double?
	var subTotal : Int?
	var couponCode : String?
	var discountAmount : Int?
	var deliveryCharges : Int?
	var finalAmount : Int?
	var isFinished : Int?
	var orderStatus : String?
	var paymentType : String?
	var paymentStatus : String?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

		id <- map["id"]
		userId <- map["user_id"]
		reference <- map["reference"]
		addressId <- map["address_id"]
		address <- map["address"]
		cityId <- map["city_id"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		subTotal <- map["sub_total"]
		couponCode <- map["coupon_code"]
		discountAmount <- map["discount_amount"]
		deliveryCharges <- map["delivery_charges"]
		finalAmount <- map["final_amount"]
		isFinished <- map["is_finished"]
		orderStatus <- map["order_status"]
		paymentType <- map["payment_type"]
		paymentStatus <- map["payment_status"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
	}

}
