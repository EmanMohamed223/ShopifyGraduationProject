//
//  ResponseSubCategoryApi.swift
//  ShopfiyProjectTests
//
//  Created by Asmaa_Abdelfattah on 14/12/1401 AP.
//

import Foundation
import XCTest
@testable import ShopfiyProject
class ResponseSubCategoryShirts : XCTestCase{
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGetMenCategoryWithShirtsubCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 0).appending(chooseSubCategory(index: 0))),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
         
            XCTAssertNotEqual(response.products.count, 0 , "Men Category with shirts Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testGetWomenCategoryWithShirtsubCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 1).appending(chooseSubCategory(index: 0))),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
           
            XCTAssertNotNil(response.products, file: "Women Category with shirts Api Failed")
    
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testGetKidCategoryWithShirtsubCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 2)).appending(chooseSubCategory(index: 0)),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
         
            XCTAssertNotNil(response.products, file: "Kid Category with shirts Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
    func testGetSaleCategoryWithShirtsubCategoryApi(){
        let expectation = expectation(description: "Waiting for API")
        
        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 3)).appending(chooseSubCategory(index: 0)),
              compiletionHandler: { data in
            guard let response : ResponseProducts = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }
         
            XCTAssertNotNil(response.products, file: "Sale Category with shirts Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
}
