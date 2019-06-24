//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Maxime on 20/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import Foundation
import Alamofire

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

class NetworkError: Error {}
static let networkError = NetworkError()
    
    static var correctRecipesData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipesData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var correctRecipesDetailsData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "RecipesDetailsData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
    
}
