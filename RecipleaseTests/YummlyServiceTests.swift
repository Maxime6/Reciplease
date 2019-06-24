//
//  YummlyServiceTests.swift
//  RecipleaseTests
//
//  Created by Maxime on 20/05/2019.
//  Copyright © 2019 Maxime. All rights reserved.
//

import XCTest
@testable import Reciplease

class YummlyServiceTests: XCTestCase {

    // Mark: GetRecipesData Tests
    
    func testGetRecipesDataShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let ingredients = [String]()
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(ingrdients: ingredients) { (success, recipeData) in
            XCTAssertFalse(success)
            XCTAssertNil(recipeData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesDataShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let ingredients = [String]()

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(ingrdients: ingredients) { success, recipeData in
            XCTAssertFalse(success)
            XCTAssertNil(recipeData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
//
    func testGetRecipesDataShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctRecipesData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let ingredients = [String]()

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(ingrdients: ingredients) { success, recipeData in
            XCTAssertFalse(success)
            XCTAssertNil(recipeData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipesDataShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let ingredients = [String]()

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(ingrdients: ingredients) { success, recipeData in
            XCTAssertFalse(success)
            XCTAssertNil(recipeData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipesDataShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let ingredients = [String]()

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(ingrdients: ingredients) { success, recipeData in
            XCTAssertFalse(success)
            XCTAssertNil(recipeData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipesDataShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctRecipesData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let ingredients = [String]()

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getRecipes(ingrdients: ingredients) { success, recipeData in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipeData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    // Mark: RecipesDetailsDataTests
    
    func testGetRecipesDetailsDataShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let recipeId = ""
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getDetailsRecipes(recipeId: recipeId) { (success, recipesDetailsData) in
            XCTAssertFalse(success)
            XCTAssertNil(recipesDetailsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesDetailsDataShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let recipeId = ""
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getDetailsRecipes(recipeId: recipeId) { success, recipesDetailsData in
            XCTAssertFalse(success)
            XCTAssertNil(recipesDetailsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    //
    func testGetRecipesDetailsDataShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctRecipesDetailsData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let recipeId = ""
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getDetailsRecipes(recipeId: recipeId) { success, recipesDetailsData in
            XCTAssertFalse(success)
            XCTAssertNil(recipesDetailsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesDetailsDataShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let recipeId = ""
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getDetailsRecipes(recipeId: recipeId) { success, recipesDetailsData in
            XCTAssertFalse(success)
            XCTAssertNil(recipesDetailsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesDetailsDataShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let recipeId = ""
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getDetailsRecipes(recipeId: recipeId) { success, recipesDetailsData in
            XCTAssertFalse(success)
            XCTAssertNil(recipesDetailsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesDetailsDataShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctRecipesDetailsData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let yummlyService = YummlyService(yummlySession: yummlySessionFake)
        let recipeId = ""
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        yummlyService.getDetailsRecipes(recipeId: recipeId) { success, recipesDetailsData in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipesDetailsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

}
