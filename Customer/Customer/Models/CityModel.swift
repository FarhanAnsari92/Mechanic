/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

class CityModel : Mappable, Equatable {
    
	var id : Int?
	var name : String?
	var status : Bool?
	var createdBy : Int?
	var updatedBy : Int?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?

    required init?(map: Map) {

	}

    func mapping(map: Map) {

		id        <- map["id"]
		name      <- map["name"]
		status    <- map["status"]
		createdBy <- map["created_by"]
		updatedBy <- map["updated_by"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
	}
    
    static func == (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.id == rhs.id
    }

}
