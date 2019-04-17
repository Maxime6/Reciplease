//
//  YummlyProtocol.swift
//  Reciplease
//
//  Created by Maxime on 17/04/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import Alamofire

protocol YummlyProtocol {
    var urlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension YummlyProtocol {
    var urlStringApi: String {
        let urlString = ""
        return urlString
    }
}
