//
//  MockNTMenCategory.swift
//  ShopfiyProjectTests
//
//  Created by Asmaa_Abdelfattah on 14/12/1401 AP.
//

import Foundation
@testable import ShopfiyProject
import XCTest
final class MockNTMenCategoryApi : XCTestCase{
    var mockMangerCategory : MockNetworkManagerCategory?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockMangerCategory = MockNetworkManagerCategory()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockMangerCategory = nil
        
    }
    func testCategoryApiWithMocking(){
        mockMangerCategory?.loadDataFromURL(url:  getURL(endPoint: "products.json")!.appending(chooseMainCategory (index : 0)), compiletionHandler: { data in
            guard let response : ResponseProducts = data else
            {
                XCTFail()
                
                return
            }
            XCTAssertNotEqual(response.products.count, 0 , "Men Category Api Failed")
        })
    }
    
}
