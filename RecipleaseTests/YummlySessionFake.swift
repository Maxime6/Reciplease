//
//  YummlySessionFake.swift
//  RecipleaseTests
//
//  Created by Maxime on 20/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class YummlySessionFake: YummlySession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        super.init()
    }
    
    override func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        let urlRequest = URLRequest(url: URL(string: searchRecipeUrlStringApi)!)
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
    
}
