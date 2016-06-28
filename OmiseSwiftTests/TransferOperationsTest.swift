import Foundation
import XCTest
import Omise

class TransferOperationsTest {
    var testClient: Client {
        let config = Config(
            publicKey: "pkey_test_52d6po3fvio2w6tefpb",
            secretKey: "skey_test_52d6ppdms4p1jhnkigq",
            apiVersion: nil,
            queue: (NSOperationQueue.currentQueue() ?? NSOperationQueue.mainQueue())
        )
        
        return Client(config: config)
    }
    
    func testTransferRetrive() {
        
    }
}