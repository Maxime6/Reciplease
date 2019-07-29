//
//  YummlyProtocol.swift
//  Reciplease
//
//  Created by Maxime on 07/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import Alamofire

protocol YummlyProtocol {
    var searchRecipeUrlStringApi: String { get }
    var getRecipeUrlStringApi: String { get }
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
