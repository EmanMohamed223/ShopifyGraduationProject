//
//  ResponseProducts.swift
//  ShopfiyProjectTests
//
//  Created by Asmaa_Abdelfattah on 10/12/1401 AP.
//
import Foundation
import XCTest
@testable import ShopfiyProject


class ResponseProductsApi : XCTestCase{
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
 
   
    func testGetProductApi(){
       

        let expectation = expectation(description: "Waiting for API")

        NetworkService.shared.fetchData (url: getURL(endPoint: "products.json"),
              compiletionHandler: { data in
            guard let response : ResponseProducts  = data
            else
            {
                XCTFail()
                expectation.fulfill()
                return
            }

            XCTAssertNotEqual(response.products.count, 0 , "Product Api Failed")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5,handler: nil)
    }
}
