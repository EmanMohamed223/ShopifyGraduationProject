//
//  ResponseCategory.swift
//  ShopfiyProjectTests
//
//  Created by Asmaa_Abdelfattah on 10/12/1401 AP.
//

import Foundation
import XCTest
@testable import ShopfiyProject


class ResponseMainCategory : XCTestCase{
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGetMenCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 0)),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
         
            XCTAssertNotEqual(response.products.count, 0 , "Men Category Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testGetWomenCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 1)),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
         
            XCTAssertNotEqual(response.products.count, 0 , "Women Category Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testGetKidCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 2)),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
         
            XCTAssertNotEqual(response.products.count, 0 , "Kid Category Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testGetSaleCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 3)),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
         
            XCTAssertNotEqual(response.products.count, 0 , "Sale Category Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
}
