//
//  Message.swift
//  friends
//
//  Created by Soeb on 2/17/17.
//  Copyright © 2017 Soeb. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var fromId:String?
    var text:String?
    var timestamp:NSNumber?
    var toId:String?
    
    func chatPartnerId() -> String? {
        if fromId == FIRAuth.auth()?.currentUser?.uid {
            return toId
        } else {
            return fromId
        }
    }

}
