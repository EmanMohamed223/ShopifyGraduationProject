//
//  MockNTBrandsApi.swift
//  ShopfiyProjectTests
//
//  Created by Asmaa_Abdelfattah on 14/12/1401 AP.
//

import Foundation
@testable import ShopfiyProject
import XCTest

final class MockNTBrandsApi : XCTestCase{
    var mockManger : MockNetworkManagerBrand?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockManger = MockNetworkManagerBrand()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockManger = nil
        
    }
    func testBrandsApiWithMocking(){
        mockManger?.loadDataFromURL(url:  getURL(endPoint: "smart_collections.json?since_id=482865238")!, compiletionHandler: { data in
            guard let response : SmartCollection = data else
            {
                XCTFail()
                
                return
            }
            XCTAssertNotEqual(response.smart_collections.count, 0 , "Brands Api Failed")
        })
    }
    
}
