//
//  User.swift
//  SwiftStreaming
//
//  Created by Renu Punjabi on 12/27/17.
//  Copyright © 2017 Renu Punjabi. All rights reserved.
//

import Foundation

//{"from":{"id":"vsp4H7gH9Lk=","name":"Seth Rowland"},"to":{"id":"0pYKaAjg1JI=","name":"Adrian Newman"},"areFriends":true,"timestamp":"1352102418944"}


struct User {
    var userName: String?
    var friendName: String?
    var isFriend: Bool?
    var timeStamp: String?
    
    init(userDictionary: NSDictionary) {
        if let fromDict = userDictionary["from"] as? NSDictionary {
            userName = fromDict["name"] as? String
        }
        if let toDict = userDictionary["to"] as? NSDictionary {
            friendName = toDict["name"] as? String
        }
        isFriend = userDictionary["areFriends"] as? Bool
        timeStamp = userDictionary["timestamp"] as? String
    }
}
