//
//  FixtureTestCase.swift
//  OmiseSwift
//
//  Created by Pitiphong Phongpattranont on 8/29/2559 BE.
//  Copyright © 2559 Omise. All rights reserved.
//

import XCTest
@testable import Omise

class FixtureTestCase: OmiseTestCase {
    var testClient: FixtureClient {
        let config = Config(
            publicKey: "pkey_test_5511txgnw3t6tqqlf0v",
            secretKey: "skey_test_5511tympbgf8im3jhjv",
            apiVersion: nil,
            queue: (OperationQueue.current ?? OperationQueue.main)
        )
        
        return FixtureClient(config: config)
    }
}
