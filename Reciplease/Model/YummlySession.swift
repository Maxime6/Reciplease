//
//  YummlySession.swift
//  Reciplease
//
//  Created by Maxime on 17/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import Alamofire

class YummlySession: YummlyProtocol {
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { (responsData) in
            completionHandler(responsData)
        }
    }
    
    
}
