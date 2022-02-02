//
//  ChatModel.swift
//  Customer
//
//  Created by Mohammad Farhan on 2/2/22.
//

import ObjectMapper

class MessageModel: Mappable {
    
    var messageId: Int?
    var message: String?
    var receiverId: Int?
    var userId: Int?
    var userName: String?
    var threadId: Int?
    
    var isMe: Bool {
        if let userIdFromLocal = Helper.getUser()?.id,
            let userIdFromServer = self.userId {
            return userIdFromLocal == userIdFromServer
        }
        return false
    }
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        messageId <- map["id"]
        message <- map["message"]
        receiverId <- map["receiver_id"]
        userId <- map["user_id"]
        userName <- map["username"]
        threadId <- map["thread_id"]
    }
}

class ChatModel: Mappable {
    
    var messages: [MessageModel]?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        messages <- map["messages"]
    }
}
