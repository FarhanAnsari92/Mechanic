//
//  SocketIOManager.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/01/2022.
//

import SocketIO

enum EventListener: String {
    case riderLocationSuccess = "RiderLocationSuccess"
    case notifyUserNewRiderLocation = "NotifyUserNewRiderLocation"
    case getThreads
    case threadJoined
}

enum EventEmmiter: String {
    case Init = "Init"
    case getRiderLastLocation = "GetRiderLastLocation"
    case updateRiderLocation = "UpdateRiderLocation"
    case getUserThreads
    case joinRoom
}

class SocketIOManager {
    
    let baseURLSocket = URL(string: "http://motox.aspenweather.net:3007")!
    private var manager: SocketManager
    
    private var socket: SocketIOClient

    private static var sharedManager: SocketIOManager = {
        let socketIOManager = SocketIOManager()
        return socketIOManager
    }()
    
    class var shared: SocketIOManager {
        return sharedManager
    }
    
    var shouldRemovePersistedId: Bool = false
    
    private init() {
        
        manager = SocketManager(
            socketURL: baseURLSocket,
            config: [
                /*.log(true), */
                .forceWebsockets(true),
                .reconnects(true)
            ]
        )
        
        socket = manager.defaultSocket
    }
    
}

extension SocketIOManager {
    
    var isConnected: Bool {
        return self.manager.status.active
    }
    
//    func connectSocketClient(onSuccess: (([Any],SocketAckEmitter) -> Void)? = nil, onFailure: (([Any],SocketAckEmitter) -> Void)? = nil) {
//
//        if !SocketIOManager.shared.isConnected {
//            self.establishConnection()
//        }
////        socket.on(Event.authSuccess.rawValue) { (data, ack) in
////            print("----- CONNECT -----")
////            onSuccess?(data,ack)
////        }
//
////        socket.onAny { (event) in
////            print("event.event - ", event.event)
////            print("isConnectd - ", self.isConnected)
////        }
//    }
    
    func establishConnection() {
        print("establishConnection()")
        manager.connect()
        self.addEvents()
        
//        if !SocketIOManager.shared.isConnected {
//            self.establishConnection()
//            print("emit user id")
//            self.emit("Init", parameters: ["user_id": "7"])
//        }
        
        
    }
    
    func emit(_ event: EventEmmiter, parameters: [String:Any]) {
        if !SocketIOManager.shared.isConnected {
            self.establishConnection()
        }
        print("Emit Event - ", event.rawValue, " data - ", parameters)
        socket.emit(event.rawValue, with: [parameters])
    }
    
    func on(_ event: EventListener,_ completion: @escaping (([Any],SocketAckEmitter) -> Void)) {
//        if !SocketIOManager.shared.isConnected {
//            self.establishConnection()
//        }
        self.off(event)
        print("Listen Event - ", event.rawValue)
        socket.on(event.rawValue) { data, ack in
            completion(data, ack)
        }
        
        
    }
    
    func off(_ event: EventListener) {
        socket.off(event.rawValue)
    }
    
    func addEvents() {
        addSocketClientEvents()
//        addCustomEvents()
    }
    
//    func addCustomEvents() {
//        SocketIOManager.shared.on("RiderLocationSuccess") { (data, ack) in
//            print("socket event data - ", data)
//            print("socket event ack - ", ack)
//        }
//    }
    
    func addSocketClientEvents() {
        
//        socket.onAny { (event) in
//            print("event.event - ", event.event)
//            print("isConnectd - ", self.isConnected)
//        }
        
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Socket Connected")
            self.emit(EventEmmiter.Init, parameters: ["user_id": "7"])
        }
        
        socket.on(clientEvent: .disconnect) { (data, ack) in
            print("Socket Disconnected")
        }
        
        socket.on(clientEvent: .error) { (data, ack) in
            print("socket error - ", data)
        }
    }
    
}
